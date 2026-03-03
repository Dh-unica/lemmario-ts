import { test, expect } from '@playwright/test'

/**
 * Test E2E per il fix del campo livello_razionalita nelle definizioni.
 *
 * Bug: il dropdown HTML restituiva una stringa (es. "8") ma Payload
 * si aspetta un numero intero per i campi relationship.
 * Fix: cleanRelationship() in useSync.ts ora converte stringhe numeriche in numeri.
 *
 * Questo test:
 * 1. Effettua login nell'admin Payload
 * 2. Naviga al form custom del lemma "cognoscere"
 * 3. Aggiunge una nuova definizione con livello_razionalita selezionato
 * 4. Salva e verifica che NON compaia l'errore di validazione
 * 5. Pulisce eliminando la definizione aggiunta
 */

const ADMIN_URL = 'http://localhost:3000/admin'
const API_URL = 'http://localhost:3000/api'
const LEMMA_ID = 270 // cognoscere

test.describe('Fix livello_razionalita - Salvataggio definizioni', () => {
  test.use({ baseURL: 'http://localhost:3000' })

  test.beforeEach(async ({ page }) => {
    // Login nell'admin Payload
    await page.goto(`${ADMIN_URL}/login`)
    await page.fill('input[name="email"]', 'admin@lemmario.dev')
    await page.fill('input[name="password"]', 'password')
    await page.click('button[type="submit"]')
    await page.waitForURL(/\/admin(?!\/login)/, { timeout: 10000 })
  })

  test('salvare una definizione con livello_razionalita non produce errore di validazione', async ({ page }) => {
    // Naviga al form custom del lemma
    await page.goto(`${ADMIN_URL}/collections/lemmi/${LEMMA_ID}`)

    // Attendi che il form custom si carichi (ha il titolo "Modifica Lemma")
    await page.waitForSelector('text=Modifica Lemma', { timeout: 15000 })

    // Conta le definizioni esistenti prima del test
    const defCardsBefore = await page.locator('.definizione-card').count()

    // Naviga allo step "Definizioni" (step 3)
    await page.click('button.tab-button:has-text("Definizioni")')
    await page.waitForSelector('.definizioni-step', { timeout: 5000 })

    // Aggiungi una nuova definizione
    await page.click('button.btn-add-def')

    // Trova l'ultima definizione card (quella appena aggiunta)
    const newDefCard = page.locator('.definizione-card').last()
    await expect(newDefCard).toBeVisible()

    // Compila il testo della definizione
    await newDefCard.locator('.def-testo').fill('TEST E2E - definizione di prova per fix livello_razionalita')

    // Seleziona un livello di razionalita dal dropdown (il campo critico del bug)
    // Usa l'ultimo select visibile (quello della nuova definizione)
    const livelloSelect = newDefCard.locator('select[id^="livello-"]')
    await expect(livelloSelect).toBeVisible()

    // Seleziona "1. Concetti astratti" (id=8) tramite valore
    // Il dropdown usa l'id numerico come value (es. "8")
    await livelloSelect.selectOption({ value: '8' })

    // Verifica che il valore sia stato impostato
    const selectedValue = await livelloSelect.inputValue()
    expect(selectedValue).toBeTruthy()
    expect(selectedValue).not.toBe('')

    // Salva tutto
    await page.click('button.btn-save')

    // Attendi il completamento del salvataggio (max 10 secondi)
    // Il bug causava un errore-banner con "Il seguente campo non è valido: livello_razionalita"
    // Verifica che NON compaia l'errore
    await page.waitForTimeout(3000)

    const errorBanner = page.locator('.error-banner')
    const hasError = await errorBanner.isVisible().catch(() => false)

    if (hasError) {
      const errorText = await errorBanner.textContent()
      // Fail esplicito con il messaggio di errore
      expect(errorText).not.toContain('livello_razionalita')
    }

    // Verifica che lo status badge indichi "Salvato"
    await expect(page.locator('.status-badge.saved')).toBeVisible({ timeout: 10000 })

    // PULIZIA: elimina la definizione di test
    // Ricarica per avere lo stato aggiornato
    await page.goto(`${ADMIN_URL}/collections/lemmi/${LEMMA_ID}`)
    await page.waitForSelector('text=Modifica Lemma', { timeout: 15000 })
    await page.click('button.tab-button:has-text("Definizioni")')
    await page.waitForSelector('.definizioni-step', { timeout: 5000 })

    // Trova la definizione di test e eliminala
    const testDef = page.locator('.definizione-card', {
      has: page.locator('.def-testo[value*="TEST E2E"]')
    })

    if (await testDef.isVisible().catch(() => false)) {
      // Prepara il dialog handler per la conferma di eliminazione
      page.once('dialog', dialog => dialog.accept())
      await testDef.locator('button.btn-delete-def').click()

      // Salva la cancellazione
      await page.click('button.btn-save')
      await expect(page.locator('.status-badge.saved')).toBeVisible({ timeout: 10000 })
    }
  })

  test('il dropdown livello_razionalita carica le opzioni correttamente', async ({ page }) => {
    await page.goto(`${ADMIN_URL}/collections/lemmi/${LEMMA_ID}`)
    await page.waitForSelector('text=Modifica Lemma', { timeout: 15000 })

    // Naviga allo step Definizioni
    await page.click('button.tab-button:has-text("Definizioni")')
    await page.waitForSelector('.definizioni-step', { timeout: 5000 })

    // Verifica che esista almeno un dropdown livello con opzioni
    const firstSelect = page.locator('select[id^="livello-"]').first()

    if (await firstSelect.isVisible().catch(() => false)) {
      const options = firstSelect.locator('option')
      // Deve avere almeno 2 opzioni: "Nessuno" + almeno 1 livello
      const count = await options.count()
      expect(count).toBeGreaterThanOrEqual(2)

      // La prima opzione deve essere "Nessuno" (valore vuoto)
      const firstOptionValue = await options.first().getAttribute('value')
      expect(firstOptionValue).toBe('')
    }
  })
})

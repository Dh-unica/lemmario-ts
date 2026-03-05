import { MigrateUpArgs, MigrateDownArgs } from '@payloadcms/db-postgres'
import { sql } from 'drizzle-orm'

/**
 * Aggiunge campi strutturati per le date alle fonti:
 * - anno_inizio: anno di inizio (intero, per ordinamento cronologico)
 * - anno_fine: anno di fine per intervalli temporali
 * - data_circa: flag per date approssimative
 */
export async function up({ payload }: MigrateUpArgs): Promise<void> {
  await payload.db.drizzle.execute(sql`
    ALTER TABLE "fonti" ADD COLUMN IF NOT EXISTS "anno_inizio" numeric;
    ALTER TABLE "fonti" ADD COLUMN IF NOT EXISTS "anno_fine" numeric;
    ALTER TABLE "fonti" ADD COLUMN IF NOT EXISTS "data_circa" boolean DEFAULT false;
  `)
}

export async function down({ payload }: MigrateDownArgs): Promise<void> {
  await payload.db.drizzle.execute(sql`
    ALTER TABLE "fonti" DROP COLUMN IF EXISTS "anno_inizio";
    ALTER TABLE "fonti" DROP COLUMN IF EXISTS "anno_fine";
    ALTER TABLE "fonti" DROP COLUMN IF EXISTS "data_circa";
  `)
}

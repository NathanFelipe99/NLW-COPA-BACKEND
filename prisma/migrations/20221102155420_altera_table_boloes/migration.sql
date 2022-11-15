-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Bolao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "anTitulo" TEXT NOT NULL,
    "caBolao" TEXT NOT NULL,
    "dtIncSys" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "boInativo" INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "new_Bolao" ("anTitulo", "caBolao", "dtIncSys", "id") SELECT "anTitulo", "caBolao", "dtIncSys", "id" FROM "Bolao";
DROP TABLE "Bolao";
ALTER TABLE "new_Bolao" RENAME TO "Bolao";
CREATE UNIQUE INDEX "Bolao_caBolao_key" ON "Bolao"("caBolao");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

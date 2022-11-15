-- CreateTable
CREATE TABLE "Usuario" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nmUsuario" TEXT NOT NULL,
    "anEmail" TEXT NOT NULL,
    "blAvatar" TEXT,
    "dtIncSys" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "boInativo" INTEGER NOT NULL DEFAULT 0
);

-- CreateTable
CREATE TABLE "Jogo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dtJogo" DATETIME NOT NULL,
    "caSelecaoMandante" TEXT NOT NULL,
    "caSelecaoVisitante" TEXT NOT NULL,
    "dtIncSys" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Participante" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "usuarioId" TEXT NOT NULL,
    "bolaoId" TEXT NOT NULL,
    CONSTRAINT "Participante_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Participante_bolaoId_fkey" FOREIGN KEY ("bolaoId") REFERENCES "Bolao" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Palpite" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nrPontosMandante" INTEGER NOT NULL,
    "nrPontosVisitante" INTEGER NOT NULL,
    "dtIncSys" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "jogoId" TEXT NOT NULL,
    "participanteId" TEXT NOT NULL,
    CONSTRAINT "Palpite_jogoId_fkey" FOREIGN KEY ("jogoId") REFERENCES "Jogo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Palpite_participanteId_fkey" FOREIGN KEY ("participanteId") REFERENCES "Participante" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Bolao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "anTitulo" TEXT NOT NULL,
    "caBolao" TEXT NOT NULL,
    "dtIncSys" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "boInativo" INTEGER NOT NULL DEFAULT 0,
    "criadorId" TEXT,
    CONSTRAINT "Bolao_criadorId_fkey" FOREIGN KEY ("criadorId") REFERENCES "Usuario" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Bolao" ("anTitulo", "boInativo", "caBolao", "dtIncSys", "id") SELECT "anTitulo", "boInativo", "caBolao", "dtIncSys", "id" FROM "Bolao";
DROP TABLE "Bolao";
ALTER TABLE "new_Bolao" RENAME TO "Bolao";
CREATE UNIQUE INDEX "Bolao_caBolao_key" ON "Bolao"("caBolao");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_anEmail_key" ON "Usuario"("anEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Participante_usuarioId_bolaoId_key" ON "Participante"("usuarioId", "bolaoId");

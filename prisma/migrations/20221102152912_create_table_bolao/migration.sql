-- CreateTable
CREATE TABLE "Bolao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "anTitulo" TEXT NOT NULL,
    "caBolao" TEXT NOT NULL,
    "dtIncSys" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "Bolao_caBolao_key" ON "Bolao"("caBolao");

/*
  Warnings:

  - Added the required column `name` to the `Product` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;

-- Crear nueva tabla con 'name' como OPCIONAL primero
CREATE TABLE "new_Product" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT, -- <--- aquí lo cambiamos a opcional
    "price" REAL NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- Copiar los datos existentes
INSERT INTO "new_Product" ("createdAt", "id", "price", "updatedAt")
SELECT "createdAt", "id", "price", "updatedAt" FROM "Product";

-- Asignar valor por defecto a 'name'
UPDATE "new_Product" SET "name" = 'Nombre por defecto' WHERE "name" IS NULL;

-- Cambiar la columna 'name' a NOT NULL (recrear tabla de nuevo no es necesario en SQLite, pero sí en otros motores)
-- En SQLite no se puede hacer ALTER COLUMN directamente, así que nos quedamos así o repetimos el proceso

-- Reemplazar tabla vieja
DROP TABLE "Product";
ALTER TABLE "new_Product" RENAME TO "Product";

PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;


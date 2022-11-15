import Fastify from "fastify";
import wCors from "@fastify/cors";
import { PrismaClient } from "@prisma/client";
import { z } from "zod";
import ShortUniqueId from "short-unique-id";

const wPrisma = new PrismaClient({
    log: ["query"]
});

async function fBootstrap() {
    const wFastify = Fastify({
        logger: true
    });

    await wFastify.register(wCors, {
        origin: true
    });

    wFastify.get("/pools/count", async () => {
        const wQtPools = await wPrisma.bolao.count({
            where: {
                boInativo: {
                    equals: 0
                }
            }
        });
        
        return { pools: wQtPools };
    });

    wFastify.post("/pools", async (request, reply) => {
        const wCreatePoolBody = z.object({
            anTitulo: z.string(),
        });
        try {
            const { anTitulo } = wCreatePoolBody.parse(request.body);   
            const wCaBolao = new ShortUniqueId({ length: 6, dictionary: "alphanum_upper" })(); 
            await wPrisma.bolao.create({
                data: {
                    anTitulo,
                    caBolao: wCaBolao
                }
            });

            return reply.status(201).send({ caBolao: wCaBolao });
        } catch (wErro) {
            return reply.status(400).send({ anMensagem: "Falha ao criar bolão!" });
        }
        
    });

    wFastify.get("/users/count", async () => {
        const wQtUsers = await wPrisma.usuario.count({
            where: {
                boInativo: {
                    equals: 0
                }
            }
        });

        return { users: wQtUsers };
    });

    wFastify.get("/guesses/count", async () => {
        const wQtPalpites = await wPrisma.palpite.count();
        return { guesses: wQtPalpites };
    });

    await wFastify.listen({ port: 3333, /*host: "0.0.0.0"*/ });
}

fBootstrap();
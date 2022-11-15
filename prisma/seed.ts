import { PrismaClient } from "@prisma/client";

const wPrisma = new PrismaClient();

async function fMain() {
    const wUsuario = await wPrisma.usuario.create({
        data: {
            nmUsuario: "John Doe",
            anEmail: "john_doe@gmail.com",
            blAvatar: "https://github.com/NathanFelipe99.png"
        }
    });

    const wBolao = await wPrisma.bolao.create({
        data: {
            anTitulo: "Bolão Teste 1",
            caBolao: "TEST01",
            criadorId: wUsuario.id,

            participantes: {
                create: {
                    usuarioId: wUsuario.id
                }
            }
        }
    });

    await wPrisma.jogo.create({
        data: {
            dtJogo: "2022-11-20T13:00:00.000Z",
            caSelecaoMandante: "QA",
            caSelecaoVisitante: "EC"
        }
    });

    await wPrisma.jogo.create({
        data: {
            dtJogo: "2022-11-21T13:00:00.000Z",
            caSelecaoMandante: "SN",
            caSelecaoVisitante: "NL",

            palpites: {
                create: {
                    nrPontosMandante: 0,
                    nrPontosVisitante: 3,
                    participante: {
                        connect: { 
                            usuarioId_bolaoId: {
                                usuarioId: wUsuario.id,
                                bolaoId: wBolao.id
                            }
                        }
                    }
                }
            }
        }
    })
}

fMain();
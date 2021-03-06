//+------------------------------------------------------------------+
//|                                           Estrategia Samurai 1.0 |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"
#property version   "1.00"

//+------------------------------------------------------------------+
//| IMAGENS                                                          |
//+------------------------------------------------------------------+
#resource "\\Images\\logoTitulo_fundoAmarelo.bmp"
#resource "\\Images\\logoSamurai_fundoAmarelo.bmp"
#resource "\\Images\\logoTM_fundoAmarelo.bmp"
#resource "\\Images\\meditando_fundoPreto.bmp"
#resource "\\Images\\katana_fundoPreto.bmp"
#resource "\\Images\\velaVerde.bmp"
#resource "\\Images\\velaVermelha.bmp"
#resource "\\Images\\velaCinza.bmp"
#resource "\\Images\\quadranteM1.bmp"
#resource "\\Images\\quadranteM5.bmp"
#resource "\\Images\\quadranteM15.bmp"
#resource "\\Images\\maioriaVerde.bmp"
#resource "\\Images\\maioriaVermelha.bmp"
#resource "\\Images\\maioriaSem.bmp"
#resource "\\Images\\setaPara_baixo.bmp"
#resource "\\Images\\setaPara_cima.bmp"
#resource "\\Images\\botaoInicio.bmp"
#resource "\\Images\\botaoFim.bmp"

//+------------------------------------------------------------------+
//| INCLUSÕES (ARQUIVOS)                                             |
//+------------------------------------------------------------------+
#include <\\TraderModerado_Include\\RS_funcoesTempo.mqh>
#include <\\TraderModerado_Include\\RS_funcoesVelas.mqh>
#include <\\TraderModerado_Include\\RS_funcoesGraficas.mqh>
#include <\\TraderModerado_Include\\RS_funcoesMatriciais.mqh>
#include <\\TraderModerado_Include\\RS_funcoesMatematicas.mqh>
#include <\\TraderModerado_Include\\RS_funcoesEstrategias.mqh>
#include <\\TraderModerado_Include\\RS_funcoesEstatisticas.mqh>

//+------------------------------------------------------------------+
//| ENUMERAÇÕES                                                      |
//+------------------------------------------------------------------+
enum HORA
  {
   ZERO                 = 00,   //00
   UMA                  = 01,   //01
   DUAS                 = 02,   //02
   TRES                 = 03,   //03
   QUATRO               = 04,   //04
   CINCO                = 05,   //05
   SEIS                 = 06,   //06
   SETE                 = 07,   //07
   OITO                 = 08,   //08
   NOVE                 = 09,   //09
   DEZ                  = 10,   //10
   ONZE                 = 11,   //11
   DOZE                 = 12,   //12
   TREZE                = 13,   //13
   QUATORZE             = 14,   //14
   QUINZE               = 15,   //15
   DEZESSEIS            = 16,   //16
   DEZESSETE            = 17,   //17
   DEZOITO              = 18,   //18
   DEZENOVE             = 19,   //19
   VINTE                = 20,   //20
   VINTE_E_UM           = 21,   //21
   VINTE_E_DOIS         = 22,   //22
   VINTE_E_TRES         = 23    //23
  };

enum MINUTO
  {
   ZERO_M               = 00,   //00
   QUINZE_M             = 15,   //15
   TRINTA_M             = 30,   //30
   QUARENTA_E_CINCO_M   = 45    //45
  };

enum BARREIRA
  {
   UM                   = 1,     //(1) UM ERRO
   DOIS                 = 2,     //(2) DOIS ERROS
   TRES                 = 3,     //(3) TRÊS ERROS
   QUATRO               = 4,     //(4) QUATRO ERROS
   CINCO                = 5,     //(5) CINCO ERROS
   SEIS                 = 6,     //(6) SEIS ERROS
   SETE                 = 7,     //(7) SETE ERROS
   OITO                 = 8,     //(8) OITO ERROS
   NOVE                 = 9,     //(9) NOVE ERROS
   DEZ                  = 10     //(10) DEZ ERROS
  };

enum METODO_LIMITE_BARREIRA
  {
   MEDIA_OCORRENCIAS    = 01,     //ENTRADAS PELA MÉDIA DAS OCORRÊNCIAS
   MAIOR_OCORRENCIA     = 02,     //ENTRADAS SOMENTE NO MAIOR ÍNDICE DE OCORRÊNCIAS
   LIMITE_FIXADO        = 03,     //ENTRADAS PELO LIMITE ESCOLHIDO (ABAIXO)
  };

enum METODO_POSICOES
  {
   PROXIMA_VELA         = 01,   // PRÓXIMA VELA
   PROXIMO_QUADRANTE    = 02    // PRÓXIMO QUADRANTE
  };

enum POSICOES
  {
   UMA                  = 01,    //(1) UMA  POSIÇÃO
   DUAS                 = 02,    //(2) DUAS POSIÇÕES
   TRES                 = 03     //(3) TRÊS POSIÇÕES
  };

//+------------------------------------------------------------------+
//| INPUT (PARÂMETROS DO USUÁRIO)                                    |
//+------------------------------------------------------------------+
sinput string              SEPARADOR1 = "-----------------------------------------------------";  //DIAS E HORÁRIOS DE NEGOCIAÇÃO
input  int                    diaAnterior_inicio                 = 00;                               //Catalogação Inicia Em Dias Anteriores? Quanto?
input  HORA                   horaInicio_analise                 = 10;                               //Hora De Início Da Análise
input  MINUTO                 minutoInicio_analise               = 00;                               //Minuto De Início Da Análise
input  HORA                   horaInicio_operacoes               = 12;                               //Horá De Início Das Operações
input  MINUTO                 minutoInicio_operacoes             = 00;                               //Minuto De Início Das Operações
input  HORA                   horaFim                            = 13;                               //Horá De Fim Das Operações
input  MINUTO                 minutoFim                          = 00;                               //Minuto De Fim Das Operações
input  int                    diaAnterior_fim                    = 00;                               //Catalogação Finaliza Quantos Dias Antes?
sinput string                 SEPARADOR2 = "-----------------------------------------------------";  //PARÃMETROS DA ESTRATÉGIA
input  BARREIRA               katanaBarreira                     = 04;                               //Barreira Kataná (Erros Para Sinal)
input  bool                   porcentagemBarreira                = true;                             //Barreira da Média de Ocorrências (50% ou +)
input  METODO_LIMITE_BARREIRA metodoLimite_barreira              = 03;                               //Método para Limite de Porcentagem de Ocorrências (Filtro)
input  double                 limiteBarreira                     = 50.0;                             //Porcentagem FIXADA de Ocorrência Mínima Para Alertas
input  POSICOES               posicoes                           = 01;                               //Número de Posições
input  METODO_POSICOES        metodoPosicoes                     = 01;                               //Método Para Duas ou Três Posições
sinput string                 SEPARADOR3 = "-----------------------------------------------------";  //PARÃMETROS DE TESTE
input  int                    diasTeste                          = 00;                               //Quantos Dias Para Testar as Estratégias

//+------------------------------------------------------------------+
//| DECLARAÇÃO DE ESTRUTURAS                                         |
//+------------------------------------------------------------------+
//--- Estrutura para determinação de hora, dia, mês. ano etc.
MqlDateTime    horarioLocal_estrutura;

MqlDateTime    horarioAtual_estrutura;

MqlDateTime    horarioDefinido_estrutura;

MqlDateTime    horarioInicio_estrutura;

MqlDateTime    horarioOperacoes_estrutura;

MqlDateTime    horarioFim_estrutura;

MqlDateTime    ajusteFino_horarioEstrutura;

MqlRates       dadosVelas[];

MqlRates       dadosVelas_horarioNegociacao[];

MqlRates       dadosVelas_quadranteAtual[];

MqlRates       dadosVelas_quadranteComplementar[];

MqlTick        precoAtual_estrutura;

//+------------------------------------------------------------------+
//| VARIÁVEIS GLOBAIS                                                |
//+------------------------------------------------------------------+
//--- Checagens Gerais
bool           parametrosAlterados = false;

bool           confirmacaoTestes = false;

//--- Variáveis de Tempo
int            diaAnterior_inicioVar = diaAnterior_inicio;

int            diaAnterior_fimVar = diaAnterior_fim;

string         horarioInicio_concatenado = ConcatenarHorario(horaInicio_analise, minutoInicio_analise);

string         horarioOperacoes_concatenado = ConcatenarHorario(horaInicio_operacoes, minutoInicio_operacoes);

string         horarioFim_concatenado = ConcatenarHorario(horaFim, minutoFim);

datetime       horarioInicio_formatado = NULL;

datetime       horarioOperacoes_formatado = NULL;

datetime       horarioFim_formatado = NULL;

int            diaSemana = 0;

bool           horarioNegociacao = false;

//--- Variáveis e Arrays de Velas
int            velasPor_quadrante = 6;

int            numeroLinhas = 0;

int            numeroLinhas_horarioNegociacao = 0;

int            numeroLinhas_historicoEntradas = 0;

string         tempoVelas = "M5";

int            decrescimoMinutos = 1;

int            decrescimoSegundos = 60;

int            decrescimoSegundos_iniciaisHN = 0;

int            decrescimoSegundos_finaisHN = 0;

int            decrescimoSegundos_quadrante = 0;

int            indiceTemporario_HN = 0;

int            tamanhoVetor_HN = 0;

datetime       periodoVelas_quadrante4[][4];

datetime       periodoVelas_quadrante4Horario_negociacao[][4];

datetime       periodoVelas_quadrante5[][5];

datetime       periodoVelas_quadrante5Horario_negociacao[][5];

datetime       periodoVelas_quadrante6[][6];

datetime       periodoVelas_quadrante6Horario_negociacao[][6];

datetime       periodoVelas_quadranteAtual[];

int            direcaoVelas[];

int            direcaoVelas_horarioNegociacao[];

int            direcaoVelas_quadranteAtual[];

int            direcaoVelas_quadranteComplementar[];

int            quadranteVelas_4[][4];

int            quadranteVelas_4horarioNegociacao[][4];

int            quadranteVelas_5[][5];

int            quadranteVelas_5horarioNegociacao[][5];

int            quadranteVelas_6[][6];

int            quadranteVelas_6horarioNegociacao[][6];

double         velasVerdes = 0;

double         velasVermelhas = 0;

double         dojis = 0;

double         velasVerdes_total = 0;

double         velasVermelhas_total = 0;

double         dojisTotal = 0;

double         velasVerdes_porcentagem = 0;

double         velasVermelhas_porcentagem = 0;

double         dojisPorcentagem = 0;

int            velasVerdes_quadrante[];

int            velasVerdes_quadranteHorario_negociacao[];

int            velasVerdes_quadranteAtual = 0;

int            velasVerdes_quadranteComplementar = 0;

int            velasVermelhas_quadrante[];

int            velasVermelhas_quadranteHorario_negociacao[];

int            velasVermelhas_quadranteAtual = 0;

int            velasVermelhas_quadranteComplementar = 0;

int            dojisQuadrante[];

int            dojisQuadrante_horarioNegociacao[];

int            dojisQuadrante_atual= 0;

int            dojisQuadrante_complementar= 0;

int            tresPrimeiras[][3];

int            tresPrimeiras_horarioNegociacao[][3];

int            tresMeio[][3];

int            tresMeio_horarioNegociacao[][3];

int            tresMeio_M5alt[][3];

int            tresMeio_M5altHorario_negociacao[][3];

int            tresUltimas[][3];

int            tresUltimas_horarioNegociacao[][3];

int            velasVerdes_tresPrimeiras[];

int            velasVerdes_tresPrimeiras_horarioNegociacao[];

int            velasVerdes_tresPrimeiras_quadranteAtual = 0;

int            velasVerdes_tresPrimeiras_quadranteComplementar = 0;

int            velasVerdes_tresMeio[];

int            velasVerdes_tresMeio_horarioNegociacao[];

int            velasVerdes_tresMeio_quadranteAtual = 0;

int            velasVerdes_tresMeio_quadranteComplementar = 0;

int            velasVerdes_tresMeio_M5alt[];

int            velasVerdes_tresMeio_M5altHorario_negociacao[];

int            velasVerdes_tresMeio_M5alt_quadranteAtual = 0;

int            velasVerdes_tresMeio_M5alt_quadranteComplementar = 0;

int            velasVerdes_tresUltimas[];

int            velasVerdes_tresUltimas_horarioNegociacao[];

int            velasVermelhas_tresPrimeiras[];

int            velasVermelhas_tresPrimeiras_horarioNegociacao[];

int            velasVermelhas_tresPrimeiras_quadranteAtual = 0;

int            velasVermelhas_tresPrimeiras_quadranteComplementar = 0;

int            velasVermelhas_tresMeio[];

int            velasVermelhas_tresMeio_horarioNegociacao[];

int            velasVermelhas_tresMeio_quadranteAtual = 0;

int            velasVermelhas_tresMeio_quadranteComplementar = 0;

int            velasVermelhas_tresMeio_M5alt[];

int            velasVermelhas_tresMeio_M5altHorario_negociacao[];

int            velasVermelhas_tresMeio_M5alt_quadranteAtual = 0;

int            velasVermelhas_tresMeio_M5alt_quadranteComplementar = 0;

int            velasVermelhas_tresUltimas[];

int            velasVermelhas_tresUltimas_horarioNegociacao[];

int            dojisPrimeiras_tres[];

int            dojisPrimeiras_tresHorario_negociacao[];

int            dojisPrimeiras_tresQuadrante_atual = 0;

int            dojisPrimeiras_tresQuadrante_complementar = 0;

int            dojisMeio_tres[];

int            dojisMeio_tresHorario_negociacao[];

int            dojisMeio_tresQuadrante_atual = 0;

int            dojisMeio_tresQuadrante_complementar = 0;

int            dojisMeio_tresM5Alt[];

int            dojisMeio_tresM5Alt_horarioNegociacao[];

int            dojisMeio_tresM5alt_quadranteAtual = 0;

int            dojisMeio_tresM5alt_quadranteComplementar = 0;

int            dojisUltimas_tres[];

int            dojisUltimas_tresHorario_negociacao[];

string         maioriaVelas[][2];

string         maioriaVelas_horarioNegociacao[][2];

int            maioriaVelas_quadranteAtual = 0;

int            maioriaVelas_quadranteComplementar = 0;

string         maioriaTres_primeiras [][2];

string         maioriaTres_primeirasHorario_negociacao [][2];

int            maioriaTres_primeirasQuadrante_atual = 0;

int            maioriaTres_primeirasQuadrante_complementar = 0;

string         maioriaTres_meio [][2];

string         maioriaTres_meioHorario_negociacao [][2];

int            maioriaTres_meioQuadrante_atual = 0;

int            maioriaTres_meioQuadrante_complementar = 0;

string         maioriaTres_meioM5_alt [][2];

string         maioriaTres_meioM5_altHorario_negociacao [][2];

int            maioriaTres_meioM5_altQuadrante_atual = 0;

int            maioriaTres_meioM5_altQuadrante_complementar = 0;

string         maioriaTres_ultimas [][2];

string         maioriaTres_ultimasHorarioNegociacao [][2];

//--- Quadrante Atual
int            velaAtual = 0;

//--- Quadrante Complementar
bool           quadranteComplementar_qualquerVela = false;

int            velaComplementar = 0;

int            quadranteComplementar_ajusteM5M15 = -60;

int            acrescimoSegundos_quadranteComplementar = 300;

//--- Arrays das Estratégias (Padrão)
string         umPara2_PDR[][2];

string         umPara2_PDRHorario_negociacao[][2];

string         doisPara3_PDR[][2];

string         doisPara3_PDRHorario_negociacao[][2];

string         tresPara4_PDR[][2];

string         tresPara4_PDRHorario_negociacao[][2];

string         quatroPara1_PDR[][2];

string         quatroPara1_PDRHorario_negociacao[][2];

string         quatroPara5_PDR[][2];

string         quatroPara5_PDRHorario_negociacao[][2];

string         cincoPara1_PDR[][2];

string         cincoPara1_PDRHorario_negociacao[][2];

string         cincoPara6_PDR[][2];

string         cincoPara6_PDRHorario_negociacao[][2];

string         seisPara1_PDR[][2];

string         seisPara1_PDRHorario_negociacao[][2];

string         maioriaVelas_para1PDR[][2];

string         maioriaVelas_para1PDR_horarioNegociacao[][2];

string         maioriaTres_primeirasPara4_PDR[][2];

string         maioriaTres_primeirasPara4_PDRHorario_negociacao[][2];

string         maioriaTres_meioPara5_PDR[][2];

string         maioriaTres_meioPara5_PDRHorario_negociacao[][2];

string         maioriaTres_meioM5_altPara6_PDR[][2];

string         maioriaTres_meioM5_altPara6_PDRHorario_negociacao[][2];

string         maioriaTres_ultimasPara1_PDR[][2];

string         maioriaTres_ultimasPara1_PDRHorario_negociacao[][2];

//--- Arrays das Estratégias (Invertido)
string         umPara2_INV[][2];

string         umPara2_INVHorario_negociacao[][2];

string         doisPara3_INV[][2];

string         doisPara3_INVHorario_negociacao[][2];

string         tresPara4_INV[][2];

string         tresPara4_INVHorario_negociacao[][2];

string         quatroPara1_INV[][2];

string         quatroPara1_INVHorario_negociacao[][2];

string         quatroPara5_INV[][2];

string         quatroPara5_INVHorario_negociacao[][2];

string         cincoPara1_INV[][2];

string         cincoPara1_INVHorario_negociacao[][2];

string         cincoPara6_INV[][2];

string         cincoPara6_INVHorario_negociacao[][2];

string         seisPara1_INV[][2];

string         seisPara1_INVHorario_negociacao[][2];

string         maioriaVelas_para1INV[][2];

string         maioriaVelas_para1INV_horarioNegociacao[][2];

string         maioriaTres_primeirasPara4_INV[][2];

string         maioriaTres_primeirasPara4_INVHorario_negociacao[][2];

string         maioriaTres_meioPara5_INV[][2];

string         maioriaTres_meioPara5_INVHorario_negociacao[][2];

string         maioriaTres_meioM5_altPara6_INV[][2];

string         maioriaTres_meioM5_altPara6_INVHorario_negociacao[][2];

string         maioriaTres_ultimasPara1_INV[][2];

string         maioriaTres_ultimasPara1_INVHorario_negociacao[][2];

//--- Arrays de Estratégias (Quadrante Atual)
string         umIgual2_quadranteAtual;

string         doisIgual3_quadranteAtual;

string         tresIgual4_quadranteAtual;

string         quatroIgual5_quadranteAtual;

string         maioriaTres_primeirasIgual4_quadranteAtual;

string         maioriaTres_meioIgual5_quadranteAtual;

//--- Complemento das Estratégias (Atual / Complementar)

bool           quadranteAcrescimo_definitivoChecado = true;

int            quadranteAcrescimo_definitivo[];

//--- Contagem de Ocorrências (PDR e LOSS)
double         umIgual2_ocorrenciasPDR[1][2];

double         doisIgual3_ocorrenciasPDR [1][2];

double         tresIgual4_ocorrenciasPDR [1][2];

double         quatroIgual1_ocorrenciasPDR [1][2];

double         quatroIgual5_ocorrenciasPDR [1][2];

double         cincoIgual1_ocorrenciasPDR [1][2];

double         cincoIgual6_ocorrenciasPDR [1][2];

double         seisIgual1_ocorrenciasPDR [1][2];

double         maioriaVelas_igual1Ocorrencias_PDR [1][2];

double         maioriaTres_primeirasIgual4_ocorrenciasPDR [1][2];

double         maioriaTres_meioIgual5_ocorrenciasPDR [1][2];

double         maioriaTres_meioM5_altIgual6_ocorrenciasPDR [1][2];

double         maioriaTres_ultimasIgual1_ocorrenciasPDR [1][2];

//--- Contagem de Ocorrências (INV e LOSS)
double         umDif2_ocorrenciasINV[1][2];

double         doisDif3_ocorrenciasINV[1][2];

double         tresDif4_ocorrenciasINV[1][2];

double         quatroDif1_ocorrenciasINV[1][2];

double         quatroDif5_ocorrenciasINV[1][2];

double         cincoDif1_ocorrenciasINV[1][2];

double         cincoDif6_ocorrenciasINV[1][2];

double         seisDif1_ocorrenciasINV[1][2];

double         maioriaVelas_dif1Ocorrencias_INV[1][2];

double         maioriaTres_primeirasDif4_ocorrenciasINV[1][2];

double         maioriaTres_meioDif5_ocorrenciasINV[1][2];

double         maioriaTres_meioM5_altDif6_ocorrenciasINV[1][2];

double         maioriaTres_ultimasDif1_ocorrenciasINV[1][2];

//--- Porcentagem (%) de Ocorrências (PDR e LOSS)
double         umIgual2_porcentagemOcorrencias_PDR;

double         doisIgual3_porcentagemOcorrencias_PDR;

double         tresIgual4_porcentagemOcorrencias_PDR;

double         quatroIgual1_porcentagemOcorrencias_PDR;

double         quatroIgual5_porcentagemOcorrencias_PDR;

double         cincoIgual1_porcentagemOcorrencias_PDR;

double         cincoIgual6_porcentagemOcorrencias_PDR;

double         seisIgual1_porcentagemOcorrencias_PDR;

double         maioriaVelas_igual1Porcentagem_ocorrenciasPDR;

double         maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR;

double         maioriaTres_meioIgual5_porcentagemOcorrencias_PDR;

double         maioriaTres_meioM5_altIgual6_porcentagemOcorrencias_PDR;

double         maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR;

double         limitePorcentagem_ocorrencias = 0;

double         matrizPorcentagem_ocorrenciasM1[18];

double         matrizPorcentagem_ocorrenciasM5[22];

double         matrizPorcentagem_ocorrenciasM15[14];

int            indiceMaior_porcentagemOcorrencias = 0;

double         maiorPorcentagem_ocorrencias = 0;

//--- Porcentagem (%) de Ocorrências (INV e LOSS)
double         umDif2_porcentagemOcorrencias_INV;

double         doisDif3_porcentagemOcorrencias_INV;

double         tresDif4_porcentagemOcorrencias_INV;

double         quatroDif1_porcentagemOcorrencias_INV;

double         quatroDif5_porcentagemOcorrencias_INV;

double         cincoDif1_porcentagemOcorrencias_INV;

double         cincoDif6_porcentagemOcorrencias_INV;

double         seisDif1_porcentagemOcorrencias_INV;

double         maioriaVelas_dif1Porcentagem_ocorrenciasINV;

double         maioriaTres_primeirasDif4_porcentagemOcorrencias_INV;

double         maioriaTres_meioDif5_porcentagemOcorrencias_INV;

double         maioriaTres_meioM5_altDif6_porcentagemOcorrencias_INV;

double         maioriaTres_ultimasDif1_porcentagemOcorrencias_INV;

//--- Porcentagem e Ranking de Ocorrências
double         porcentagemOcorrencias_organizada[][2];

double         porcentagemOcorrencias_vetor[];

double         porcentagemOcorrencias_titulo[];

//--- Concatenação dos Resultados das Estratégias PDR
string         umIgual2_concatenadaPDR;

string         umIgual2_concatenadaPDR_horarioNegociacao;

string         doisIgual3_concatenadaPDR;

string         doisIgual3_concatenadaPDR_horarioNegociacao;

string         tresIgual4_concatenadaPDR;

string         tresIgual4_concatenadaPDR_horarioNegociacao;

string         quatroIgual1_concatenadaPDR;

string         quatroIgual1_concatenadaPDR_horarioNegociacao;

string         quatroIgual5_concatenadaPDR;

string         quatroIgual5_concatenadaPDR_horarioNegociacao;

string         cincoIgual1_concatenadaPDR;

string         cincoIgual1_concatenadaPDR_horarioNegociacao;

string         cincoIgual6_concatenadaPDR;

string         cincoIgual6_concatenadaPDR_horarioNegociacao;

string         seisIgual1_concatenadaPDR;

string         seisIgual1_concatenadaPDR_horarioNegociacao;

string         maioriaVelas_igual1Concatenada_PDR;

string         maioriaVelas_igual1Concatenada_PDRhorarioNegociacao;

string         maioriaTres_primeirasIgual4_concatenadaPDR;

string         maioriaTres_primeirasIgual4_concatenadaPDR_horarioNegociacao;

string         maioriaTres_meioIgual5_concatenadaPDR;

string         maioriaTres_meioIgual5_concatenadaPDR_horarioNegociacao;

string         maioriaTres_meioM5_altIgual6_concatenadaPDR;

string         maioriaTres_meioM5_altIgual6_concatenadaPDR_horarioNegociacao;

string         maioriaTres_ultimasIgual1_concatenadaPDR;

string         maioriaTres_ultimasIgual1_concatenadaPDR_horarioNegociacao;

//--- Concatenação dos Resultados das Estratégias INV
string         umDif2_concatenadaINV;

string         umDif2_concatenadaINV_horarioNegociacao;

string         doisDif3_concatenadaINV;

string         doisDif3_concatenadaINV_horarioNegociacao;

string         tresDif4_concatenadaINV;

string         tresDif4_concatenadaINV_horarioNegociacao;

string         quatroDif1_concatenadaINV;

string         quatroDif1_concatenadaINV_horarioNegociacao;

string         quatroDif5_concatenadaINV;

string         quatroDif5_concatenadaINV_horarioNegociacao;

string         cincoDif1_concatenadaINV;

string         cincoDif1_concatenadaINV_horarioNegociacao;

string         cincoDif6_concatenadaINV;

string         cincoDif6_concatenadaINV_horarioNegociacao;

string         seisDif1_concatenadaINV;

string         seisDif1_concatenadaINV_horarioNegociacao;

string         maioriaVelas_dif1Concatenada_INV;

string         maioriaVelas_dif1Concatenada_INVhorarioNegociacao;

string         maioriaTres_primeirasDif4_concatenadaINV;

string         maioriaTres_primeirasDif4_concatenadaINV_horarioNegociacao;

string         maioriaTres_meioDif5_concatenadaINV;

string         maioriaTres_meioDif5_concatenadaINV_horarioNegociacao;

string         maioriaTres_meioM5_altDif6_concatenadaINV;

string         maioriaTres_meioM5_altDif6_concatenadaINV_horarioNegociacao;

string         maioriaTres_ultimasDif1_concatenadaINV;

string         maioriaTres_ultimasDif1_concatenadaINV_horarioNegociacao;

//--- Multiplicação da Barreira Kataná
string         katanaLoss_concatenado;

//--- Variáveis do Sinal de Entrada PDR
string         umIgual2_sinalKatana_PDR;

string         doisIgual3_sinalKatana_PDR;

string         tresIgual4_sinalKatana_PDR;

string         quatroIgual1_sinalKatana_PDR;

string         quatroIgual5_sinalKatana_PDR;

string         cincoIgual1_sinalKatana_PDR;

string         cincoIgual6_sinalKatana_PDR;

string         seisIgual1_sinalKatana_PDR;

string         maioriaVelas_igual1Sinal_katanaPDR;

string         maioriaTres_primeirasIgual4_sinalKatana_PDR;

string         maioriaTres_meioIgual5_sinalKatana_PDR;

string         maioriaTres_meioM5_altIgual6_sinalKatana_PDR;

string         maioriaTres_ultimasIgual1_sinalKatana_PDR;

//--- Variáveis do Sinal de Entrada INV
string         umDif2_sinalKatana_INV;

string         doisDif3_sinalKatana_INV;

string         tresDif4_sinalKatana_INV;

string         quatroDif1_sinalKatana_INV;

string         quatroDif5_sinalKatana_INV;

string         cincoDif1_sinalKatana_INV;

string         cincoDif6_sinalKatana_INV;

string         seisDif1_sinalKatana_INV;

string         maioriaVelas_dif1Sinal_katanaINV;

string         maioriaTres_primeirasDif4_sinalKatana_INV;

string         maioriaTres_meioDif5_sinalKatana_INV;

string         maioriaTres_meioM5_altDif6_sinalKatana_INV;

string         maioriaTres_ultimasDif1_sinalKatana_INV;

//--- Variáveis Para Contagem Estatísticas

double         quantidadeVitorias_total = 0;

double         quantidadeDerrotas_total = 0;

double         assertividadeCombinada = 0;

//--- Porcentagem e Ranking de Assertividade
double         porcentagemAssertividade_organizada[][2];

double         porcentagemAssertividade_vetor[];

double         porcentagemAssertividade_titulo[];

//--- Matrizes de Assertividade PDR
double         umIgual2_quantidadeVitoria_katanaPDR = 0;
double         umIgual2_quantidadeDerrota_katanaPDR = 0;
string         umIgual2_entradasPDR[][4];
double         umIgual2_assertividadeKatana_PDR = 0;

double         doisIgual3_quantidadeVitoria_katanaPDR = 0;
double         doisIgual3_quantidadeDerrota_katanaPDR = 0;
string         doisIgual3_entradasPDR[][4];
double         doisIgual3_assertividadeKatana_PDR = 0;

double         tresIgual4_quantidadeVitoria_katanaPDR = 0;
double         tresIgual4_quantidadeDerrota_katanaPDR = 0;
string         tresIgual4_entradasPDR[][4];
double         tresIgual4_assertividadeKatana_PDR = 0;

double         quatroIgual1_quantidadeVitoria_katanaPDR = 0;
double         quatroIgual1_quantidadeDerrota_katanaPDR = 0;
string         quatroIgual1_entradasPDR[][4];
double         quatroIgual1_assertividadeKatana_PDR = 0;

double         quatroIgual5_quantidadeVitoria_katanaPDR = 0;
double         quatroIgual5_quantidadeDerrota_katanaPDR = 0;
string         quatroIgual5_entradasPDR[][4];
double         quatroIgual5_assertividadeKatana_PDR = 0;

double         cincoIgual1_quantidadeVitoria_katanaPDR = 0;
double         cincoIgual1_quantidadeDerrota_katanaPDR = 0;
string         cincoIgual1_entradasPDR[][4];
double         cincoIgual1_assertividadeKatana_PDR = 0;

double         cincoIgual6_quantidadeVitoria_katanaPDR = 0;
double         cincoIgual6_quantidadeDerrota_katanaPDR = 0;
string         cincoIgual6_entradasPDR[][4];
double         cincoIgual6_assertividadeKatana_PDR = 0;

double         seisIgual1_quantidadeVitoria_katanaPDR = 0;
double         seisIgual1_quantidadeDerrota_katanaPDR = 0;
string         seisIgual1_entradasPDR[][4];
double         seisIgual1_assertividadeKatana_PDR = 0;

double         maioriaVelas_igual1Quantidade_vitoriaKatana_PDR = 0;
double         maioriaVelas_igual1Quantidade_derrotaKatana_PDR = 0;
string         maioriaVelas_igual1Entradas_PDR[][4];
double         maioriaVelas_igual1Assertividade_katanaPDR = 0;

double         maioriaTres_primeirasIgual4_quantidadeVitoria_katanaPDR = 0;
double         maioriaTres_primeirasIgual4_quantidadeDerrota_katanaPDR = 0;
string         maioriaTres_primeirasIgual4_entradasPDR[][4];
double         maioriaTres_primeirasIgual4_assertividadeKatana_PDR = 0;

double         maioriaTres_meioIgual5_quantidadeVitoria_katanaPDR = 0;
double         maioriaTres_meioIgual5_quantidadeDerrota_katanaPDR = 0;
string         maioriaTres_meioIgual5_entradasPDR[][4];
double         maioriaTres_meioIgual5_assertividadeKatana_PDR = 0;

double         maioriaTres_meioM5_altIgual6_quantidadeVitoria_katanaPDR = 0;
double         maioriaTres_meioM5_altIgual6_quantidadeDerrota_katanaPDR = 0;
string         maioriaTres_meioM5_altIgual6_entradasPDR[][4];
double         maioriaTres_meioM5_altIgual6_assertividadeKatana_PDR = 0;

double         maioriaTres_ultimasIgual1_quantidadeVitoria_katanaPDR = 0;
double         maioriaTres_ultimasIgual1_quantidadeDerrota_katanaPDR = 0;
string         maioriaTres_ultimasIgual1_entradasPDR[][4];
double         maioriaTres_ultimasIgual1_assertividadeKatana_PDR = 0;

//--- Matrizes de Assertividade INV
double         umDif2_quantidadeVitoria_katanaINV = 0;
double         umDif2_quantidadeDerrota_katanaINV = 0;
string         umDif2_entradasINV[][4];
double         umDif2_assertividadeKatana_INV = 0;

double         doisDif3_quantidadeVitoria_katanaINV = 0;
double         doisDif3_quantidadeDerrota_katanaINV = 0;
string         doisDif3_entradasINV[][4];
double         doisDif3_assertividadeKatana_INV = 0;

double         tresDif4_quantidadeVitoria_katanaINV = 0;
double         tresDif4_quantidadeDerrota_katanaINV = 0;
string         tresDif4_entradasINV[][4];
double         tresDif4_assertividadeKatana_INV = 0;

double         quatroDif1_quantidadeVitoria_katanaINV = 0;
double         quatroDif1_quantidadeDerrota_katanaINV = 0;
string         quatroDif1_entradasINV[][4];
double         quatroDif1_assertividadeKatana_INV = 0;

double         quatroDif5_quantidadeVitoria_katanaINV = 0;
double         quatroDif5_quantidadeDerrota_katanaINV = 0;
string         quatroDif5_entradasINV[][4];
double         quatroDif5_assertividadeKatana_INV = 0;

double         cincoDif1_quantidadeVitoria_katanaINV = 0;
double         cincoDif1_quantidadeDerrota_katanaINV = 0;
string         cincoDif1_entradasINV[][4];
double         cincoDif1_assertividadeKatana_INV = 0;

double         cincoDif6_quantidadeVitoria_katanaINV = 0;
double         cincoDif6_quantidadeDerrota_katanaINV = 0;
string         cincoDif6_entradasINV[][4];
double         cincoDif6_assertividadeKatana_INV = 0;

double         seisDif1_quantidadeVitoria_katanaINV = 0;
double         seisDif1_quantidadeDerrota_katanaINV = 0;
string         seisDif1_entradasINV[][4];
double         seisDif1_assertividadeKatana_INV = 0;

double         maioriaVelas_dif1Quantidade_vitoriaKatana_INV = 0;
double         maioriaVelas_dif1Quantidade_derrotaKatana_INV = 0;
string         maioriaVelas_dif1Entradas_INV[][4];
double         maioriaVelas_dif1Assertividade_katanaINV = 0;

double         maioriaTres_primeirasDif4_quantidadeVitoria_katanaINV = 0;
double         maioriaTres_primeirasDif4_quantidadeDerrota_katanaINV = 0;
string         maioriaTres_primeirasDif4_entradasINV[][4];
double         maioriaTres_primeirasDif4_assertividadeKatana_INV = 0;

double         maioriaTres_meioDif5_quantidadeVitoria_katanaINV = 0;
double         maioriaTres_meioDif5_quantidadeDerrota_katanaINV = 0;
string         maioriaTres_meioDif5_entradasINV[][4];
double         maioriaTres_meioDif5_assertividadeKatana_INV = 0;

double         maioriaTres_meioM5_altDif6_quantidadeVitoria_katanaINV = 0;
double         maioriaTres_meioM5_altDif6_quantidadeDerrota_katanaINV = 0;
string         maioriaTres_meioM5_altDif6_entradasINV[][4];
double         maioriaTres_meioM5_altDif6_assertividadeKatana_INV = 0;

double         maioriaTres_ultimasDif1_quantidadeVitoria_katanaINV = 0;
double         maioriaTres_ultimasDif1_quantidadeDerrota_katanaINV = 0;
string         maioriaTres_ultimasDif1_entradasINV[][4];
double         maioriaTres_ultimasDif1_assertividadeKatana_INV = 0;

//--- Variáveis e Arrays dos Painéis
string         legendasPainel1_botao1Vertical[7] = {"VELAS VERDES:",
                                                    "VELAS VERMELHAS:",
                                                    "DOJIS:",
                                                    "VELAS VERDES(%):",
                                                    "VELAS VERMELHAS(%):",
                                                    "DOJIS(%):",
                                                    "QUADRANTES:"
                                                   };

string         legendasPainel1_botao1Vertical_label[];

string         legendasPainel1_botao2Vertical[];

string         legendasPainel1_botao2Vertical_label[];

MqlDateTime    legendasPainel1_botao2Vertical_estrutura;

string         legendasPainel1_botao2Vertical_estruturaDia;

string         legendasPainel1_botao2Vertical_estruturaMes;

string         legendasPainel1_botao2Vertical_estruturaAno;

string         legendasPainel1_botao2Vertical_estruturaHora;

string         legendasPainel1_botao2Vertical_estruturaMinuto;

string         legendasPainel1_botao2Horizontal_M1[6] = {"DATA E HORÁRIO",
                                                         "QUADRANTES",
                                                         "MQ",
                                                         "M3P",
                                                         "M3M",
                                                         "M3U"
                                                        };

string         legendasPainel1_botao2Horizontal_M1Label[6];

string         legendasPainel1_botao2Horizontal_M5[7] = {"DATA E HORÁRIO",
                                                         "QUADRANTES",
                                                         "MQ",
                                                         "M3P",
                                                         "M3M",
                                                         "MM2",
                                                         "M3U"
                                                        };

string         legendasPainel1_botao2Horizontal_M5Label[7];

string         legendasPainel1_botao2Horizontal_M15[5] = {"DATA E HORÁRIO",
                                                          "QUADRANTES",
                                                          "MQ",
                                                          "M3P",
                                                          "M3U"
                                                         };

string         legendasPainel1_botao2Horizontal_M15Label[5];

string         legendasPainel1_botao4Horizontal[4] = {"ESTRATÉGIA",
                                                      "DATA INÍCIO",
                                                      "DATA FIM",
                                                      "RESULTADO"
                                                     };

string         legendasPainel1_botao4Horizontal_label[4];

string         legendasPainel2_quadranteAtual_M1[5] = {"DATA E HORÁRIO",
                                                       "Q. ATUAL / COMPL.",
                                                       "MQ",
                                                       "M3P",
                                                       "M3M"
                                                      };

string         legendasPainel2_quadranteAtual_M1Label[5];

string         legendasPainel2_quadranteAtual_M5[6] = {"DATA E HORÁRIO",
                                                       "Q. ATUAL / COMPL.",
                                                       "MQ",
                                                       "M3P",
                                                       "M3M",
                                                       "M3M2"
                                                      };

string         legendasPainel2_quadranteAtual_M5Label[6];

string         legendasPainel2_quadranteAtual_M15[4] = {"DATA E HORÁRIO",
                                                        "Q. ATUAL / COMPL.",
                                                        "MQ",
                                                        "M3P",
                                                       };

string         legendasPainel2_quadranteAtual_M15Label[4];

int            diferencaIndice_botao2 = 11;

int            indiceMinimo_vetorAtual_botao2 = 0;

int            indiceMaximo_vetorAtual_botao2 = diferencaIndice_botao2;

int            linhasGrafico_botao2 = 0;

bool           indiceFim_inicioEA_botao2 = false;

int            diferencaIndice_botao4 = 11;

int            indiceMinimo_vetorAtual_botao4 = 0;

int            indiceMaximo_vetorAtual_botao4 = diferencaIndice_botao4;

int            linhasGrafico_botao4 = 0;

bool           indiceFim_inicioEA_botao4 = false;

string         legendasPainel1_botao7[];

string         legendasPainel1_botao7Vertical_label[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string         legendasPainel1_botao8Vertical[11] = {"HORÁRIO (INÍCIO):",
                                                     "DIAS ANT. (INÍCIO):",
                                                     "HORÁRIO (OPERAÇÕES):",
                                                     "HORÁRIO (FIM):",
                                                     "DIAS ANTERIORES (FIM):",
                                                     "HORÁRIO DE NEGOCIAÇÃO: ",
                                                     "BARREIRA KATANÁ:",
                                                     "NÚMERO DE POSIÇÕES:",
                                                     "ROBÔ SAMURAI 1.0 (COPYRIGHT):",
                                                     "WEBSITE:",
                                                     "USUÁRIO:"
                                                    };

string         website = "tradermoderado.weebly.com";

string         nomeUsuario = "ISRAEL T. DE ANDRADE";

string         legendasPainel1_botao8Vertical_label[];

string         legendasPainel2[3] = {"POSIÇÃO:", "OCORRÊNCIA (%):", "MELHOR ENTRADA:"};

string         legendasPainel2_entradaLabel[3];

string         valoresPainel1_botao1[7];

string         valoresPainel1_botao1Label[7];

string         valoresPainel1_botao2M1[][5];

string         valoresPainel1_botao2M5[][6];

string         valoresPainel1_botao2M15[][4];

string         valoresPainel1_botao2Label_M1[][5];

string         quadrantePainel1_botao2Label[13];

string         valoresPainel1_botao2Label_M5[][6];

string         valoresPainel1_botao2Label_M15[][4];

string         valoresPainel1_botao2MaioriaQ_M1Label[];

string         valoresPainel1_botao2MaioriaQ_M5Label[];

string         valoresPainel1_botao2MaioriaQ_M15Label[];

string         valoresPainel1_botao2Maioria_3primeirasM1_label[];

string         valoresPainel1_botao2Maioria_3primeirasM5_label[];

string         valoresPainel1_botao2Maioria_3primeirasM15_label[];

string         valoresPainel1_botao2Maioria_3ultimasM1_label[];

string         valoresPainel1_botao2Maioria_3ultimasM5_label[];

string         valoresPainel1_botao2Maioria_3ultimasM15_label[];

string         valoresPainel1_botao2Maioria_3meioM1_label[];

string         valoresPainel1_botao2Maioria_3meioM5_label[];

string         valoresPainel1_botao2Maioria_3meioM5_altLabel[];

string         valoresPainel1_botao3Label[][4];

string         valoresPainel3_botao3[3];

string         valoresPainel3_botao3Label[3];

string         valoresPainel1_botao4[][4];

string         valoresPainel1_botao4Label[][4];

MqlDateTime    valoresPainel1_botao4EstruturaInicio;

string         valoresPainel1_botao4Estrutura_diaInicio;

string         valoresPainel1_botao4Estrutura_mesInicio;

string         valoresPainel1_botao4Estrutura_anoInicio;

string         valoresPainel1_botao4Estrutura_horaInicio;

string         valoresPainel1_botao4Estrutura_minutoInicio;

MqlDateTime    valoresPainel1_botao4EstruturaFim;

string         valoresPainel1_botao4Estrutura_diaFim;

string         valoresPainel1_botao4Estrutura_mesFim;

string         valoresPainel1_botao4Estrutura_anoFim;

string         valoresPainel1_botao4Estrutura_horaFim;

string         valoresPainel1_botao4Estrutura_minutoFim;

string         valoresPainel1_botao5Label[][3];

string         valoresPainel3_botao5[3][2];

string         valoresPainel3_botao5Label[3][2];

string         valoresPainel1_botao8[11];

string         valoresPainel1_botao8Label[11];

string         valoresPainel2[3];

string         valoresPainel2_entradaLabel[3];

string         valoresPainel2_quadranteAtual_label[];

string         ultimaEntrada;

//--- Tabelas Finais (Para Informações Visíveis)
string         tabelaFinal_ocorrencias[][4];

string         tabelaFinal_assertividade[][3];

string         tabelaFinal_historicoEntradas[][4];

MqlDateTime    tabelaFinal_historicoEntradas_colunaData_Estrutura1;

MqlDateTime    tabelaFinal_historicoEntradas_colunaData_Estrutura2;

string         assertividadeKatana_matriz[][3];

string         tabelaFinal_ocorrenciasTitulo_alternativo[];

string         tabelaFinal_ocorrenciasTitulo_alternativo2[];

string         tabelaFinal_ocorrenciasLegenda[4];

string         tabelaAssertividade_legenda[3];

string         tabelaFinal_assertividadeTitulo_alternativo[];

string         tabelaInfo_legenda[11];

string         tabelaInfo_dados[11];

string         tabelaInfo_tituloAlternativo[11];

string         tabelaEntrada[][4];

double         ordenacaoEntrada[];

int            indiceEntrada;

int            botaoSelecionado = 4;

bool           mostrarPainel = true;

int            deltaX = 10;

int            deltaX_esconder = 10000;

int            deltaY = 10;

int            tamanhoLinha = 30;

//+------------------------------------------------------------------+
//| ON INIT (FUNÇÃO DE INICIALIZAÇÃO)                                |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- Timer
   EventSetTimer(1);

//--- Horários Para Estruturas e Estruturas Para Variáveis
   TimeToStruct(TimeLocal(), horarioLocal_estrutura);

   TimeToStruct(TimeCurrent(), horarioAtual_estrutura);

   diaSemana = horarioAtual_estrutura.day_of_week;

   TimeToStruct(DefinirHorario(diaSemana), horarioDefinido_estrutura);

//--- Formata e Ajusta os Horários Selecionados
   horarioInicio_formatado = FormatarHorario(horarioDefinido_estrutura.year, horarioDefinido_estrutura.mon, horarioDefinido_estrutura.day, horarioInicio_concatenado, diaAnterior_inicio);

   horarioOperacoes_formatado = FormatarHorario(horarioDefinido_estrutura.year, horarioDefinido_estrutura.mon, horarioDefinido_estrutura.day, horarioOperacoes_concatenado, diaAnterior_inicio);

   horarioFim_formatado = FormatarHorario(horarioDefinido_estrutura.year, horarioDefinido_estrutura.mon, horarioDefinido_estrutura.day, horarioFim_concatenado, diaAnterior_fim);

//--- Horários Escolhidos Fazem Sentido (Checar)
   if(horarioInicio_formatado > horarioFim_formatado ||
      horarioInicio_formatado > horarioOperacoes_formatado ||
      horarioOperacoes_formatado > horarioFim_formatado)
     {
      Alert("Horário de Início: ", horarioInicio_formatado, " Horário de Operações: ", horarioOperacoes_formatado, " Horário de Fim: ", horarioFim_formatado);
      Alert("Horários escolhidos não fazem sentido. O Robô não foi iniciado.");
      Alert("O Horário de Início da Análise não pode ser maior ou igual ao Horário de Início das Operações nem do Fim das Operações.");
      return(INIT_FAILED);
     }
   else
      if(TimeCurrent() < horarioInicio_formatado)
        {
         Alert("O mercado abriu, mas o horário atual é menor do que o selecionado para o início das análises.");
         Alert("Por favor, escolha um horário igual ou anterior ao atual nos parâmetros do Robô.");
         return(INIT_FAILED);
        }

//+------------------------------------------------------------------+
//| BOTÕES E SETAS                                                   |
//+------------------------------------------------------------------+
   CriarBotao("Botão 1", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 34 + 8, 125, 32, "VELAS", "Arial Black", 9,
              clrBlack, clrDarkOrange, clrRed, false, false, true, "Estatísticas de Quadrantes");
   ObjectSetInteger(0, "Botão 1", OBJPROP_STATE, true);
   CriarBotao("Botão 2", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 30 + 9, 125, 32, "QUADRANTES", "Arial Black", 9,
              clrBlack, clrKhaki, clrRed, false, false, true, "Estatísticas de Quadrantes");
   CriarBotao("Botão 3", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 27, 125, 32, "OCORRÊNCIAS", "Arial Black", 9,
              clrBlack, clrPaleGreen, clrRed, false, false, true, "Ocorrências das Estratégias");
   CriarBotao("Botão 4", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 23 + 1, 125, 32, "HIST. ENTRADAS", "Arial Black", 9,
              clrBlack, clrGold, clrRed, false, false, true, "Histórico de Entradas");
   CriarBotao("Botão 5", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 19 + 2, 125, 32, "ASSERTIVIDADE", "Arial Black", 9,
              clrBlack, clrViolet, clrRed, false, false, true, "Assertividade das Estratégias");
   CriarBotao("Botão 6", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 15 + 3, 125, 32, "TESTES", "Arial Black", 9,
              clrBlack, clrChartreuse, clrRed, false, false, true, "Botão de Testes Retroativos");
   CriarBotao("Botão 7", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 11 + 4, 125, 32, "RELATÓRIO", "Arial Black", 9,
              clrBlack, clrOrange, clrRed, false, false, true, "Relatório CSV");
   CriarBotao("Botão 8", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 7 + 5, 125, 32, "SOBRE (INFO)", "Arial Black", 9,
              clrBlack, clrDodgerBlue, clrRed, false, false, true, "Informações Gerais");
   CriarBotao("Botão 9", CORNER_LEFT_LOWER, deltaX * 50,
              deltaY * 3 + 6, 125, 32, "OCULTAR (S/N)", "Arial Black", 9,
              clrBlack, clrOrangeRed, clrRed, false, false, true, "Ocultar Painéis");
   CriarBotao("Botão 10", CORNER_LEFT_LOWER, 10000,
              deltaY * 23 + 1, 125, 32, "CONFIRMAR", "Arial Black", 9,
              clrBlack, clrLightCyan, clrRed, false, false, true, "Confirma Teste Retroativo");
   CriarBotao("Botão 11", CORNER_LEFT_LOWER, 10000,
              deltaY * 19 + 2, 125, 32, "CANCELAR", "Arial Black", 9,
              clrBlack, clrLightSalmon, clrRed, false, false, true, "Cancela Teste Retroativo");
   CriarBotao("Botão 12", CORNER_LEFT_LOWER, 10000,
              deltaY * 27, 125, 32, "HIST. TESTE", "Arial Black", 9,
              clrBlack, clrGold, clrRed, false, false, true, "Histórico de Entradas do Teste");
   CriarBotao("Botão 13", CORNER_LEFT_LOWER, 10000,
              deltaY * 23 + 1, 125, 32, "ASSERT. TESTE", "Arial Black", 9,
              clrBlack, clrViolet, clrRed, false, false, true, "Assertividade do Teste Retroativo");
   CriarBotao("Botão 14", CORNER_LEFT_LOWER, 10000,
              deltaY * 19 + 2, 125, 32, "RELAT. TESTE", "Arial Black", 9,
              clrBlack, clrChartreuse, clrRed, false, false, true, "Relatório CSV Retroativo");
   CriarBotao("Botão 15", CORNER_LEFT_LOWER, 10000,
              deltaY * 15 + 3, 125, 32, "VOLTAR", "Arial Black", 9,
              clrBlack, clrOrange, clrRed, false, false, true, "Retorna à Configuração Inicial");


   PosicionarImagem_Painel("Seta 1", "::Images\\setaPara_cima.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 10000, deltaY * 39 + 3, 1000);
   PosicionarImagem_Painel("Seta 2", "::Images\\setaPara_baixo.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 10000, deltaY * 35 + 3, 1000);
   PosicionarImagem_Painel("Botao Inicio", "::Images\\botaoInicio.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 54 + 4, deltaY * 39 + 3, 1000);
   PosicionarImagem_Painel("Botao Fim", "::Images\\botaoFim.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 54 + 4, deltaY * 35 + 3, 1000);

//+------------------------------------------------------------------+
//| PAINÉIS (FUNDO)                                                  |
//+------------------------------------------------------------------+
   CriarFundo("Fundo 1", CORNER_LEFT_LOWER, deltaX, tamanhoLinha * ArrayRange(legendasPainel1_botao1Vertical, 0) + 7,
              480, tamanhoLinha * ArrayRange(legendasPainel1_botao1Vertical, 0) + 3, clrYellow, BORDER_FLAT, clrRed, false, 2);
   CriarFundo("Fundo 2", CORNER_LEFT_LOWER, deltaX * 63 + 5, deltaY * 30 + 5,
              480, deltaY * 30 + 1, clrYellow, BORDER_FLAT, clrRed, false, 2);
   CriarFundo("Fundo 3", CORNER_LEFT_LOWER, 10000, deltaY * 43,
              125, deltaY * 7 + 5, clrYellow, BORDER_FLAT, clrRed, false, 2);


   ArrayReverse(legendasPainel1_botao1Vertical, 0, WHOLE_ARRAY);
   ArrayReverse(legendasPainel1_botao8Vertical, 0, WHOLE_ARRAY);

//+------------------------------------------------------------------+
//| LOGO, TÍTULOS E IMAGENS DE ALERTA                                |
//+------------------------------------------------------------------+
   PosicionarImagem_Painel("Logo Samurai", "::Images\\logoSamurai_fundoAmarelo.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 64 + 7, deltaY * 20 + 5, 2000);
   PosicionarImagem_Painel("Logo Titulo", "::Images\\logoTitulo_fundoAmarelo.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 74 + 5, deltaY * 20 + 5, 2000);
   PosicionarImagem_Painel("Logo TM", "::Images\\logoTM_fundoAmarelo.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 100 + 5, deltaY * 20 + 5, 2000);
   PosicionarImagem_Painel("Meditando", "::Images\\meditando_fundoPreto.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 64 + 5, deltaY, 2000);
   PosicionarImagem_Painel("Katana", "::Images\\katana_fundoPreto.bmp",
                           CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 10000, deltaY, 2000);

//--- Início Bem-Sucedido
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| ON DEINIT (FUNÇÃO DE FECHAMENTO)                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- Destruir Timer
   EventKillTimer();

//--- Deletar Botões de Ação
   for(int i = 1; i <= 15; i++)
     {
      ObjectDelete(0,"Botão " + IntegerToString(i));
     }

//--- Deletar Fundos dos Painéis
   for(int i = 1; i <= 3; i++)
     {
      ObjectDelete(0,"Fundo " + IntegerToString(i));
     }

//--- Deletar Setas
   for(int i = 1; i <= 2; i++)
     {
      ObjectDelete(0,"Seta " + IntegerToString(i));
     }

//--- Deletar Botões de Início e Fim
   ObjectDelete(0,"Botao Inicio");
   ObjectDelete(0,"Botao Fim");

//--- Deletar Logos, Títulos, Imagens de Alerta e Maiorias Atuais
   ObjectDelete(0, "Logo Samurai");
   ObjectDelete(0, "Logo Titulo");
   ObjectDelete(0, "Logo TM");
   ObjectDelete(0, "Meditando");
   ObjectDelete(0, "Katana");
   ObjectDelete(0, "quadranteAtual_Painel2");
   ObjectDelete(0, "Maioria QA");
   ObjectDelete(0, "Maioria 3PQA");
   ObjectDelete(0, "Maioria 3MQA");
   ObjectDelete(0, "Maioria 3M2QA");
   ObjectDelete(0, "horarioQuadrante_atualPainel2");

//--- Deletar Texto do Painel de Estatísticas
   ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                      legendasPainel1_botao2Vertical_label,
                      legendasPainel1_botao7Vertical_label,
                      legendasPainel1_botao8Vertical_label,
                      legendasPainel1_botao2Horizontal_M1Label,
                      legendasPainel1_botao2Horizontal_M5Label,
                      legendasPainel1_botao2Horizontal_M15Label,
                      legendasPainel1_botao4Horizontal,
                      legendasPainel1_botao4Horizontal_label,
                      legendasPainel2_entradaLabel,
                      legendasPainel2_quadranteAtual_M1Label,
                      legendasPainel2_quadranteAtual_M5Label,
                      legendasPainel2_quadranteAtual_M15Label,
                      valoresPainel1_botao1Label,
                      quadrantePainel1_botao2Label,
                      valoresPainel1_botao2Label_M1,
                      valoresPainel1_botao2Label_M5,
                      valoresPainel1_botao2Label_M15,
                      valoresPainel1_botao2MaioriaQ_M1Label,
                      valoresPainel1_botao2MaioriaQ_M5Label,
                      valoresPainel1_botao2MaioriaQ_M15Label,
                      valoresPainel1_botao2Maioria_3primeirasM1_label,
                      valoresPainel1_botao2Maioria_3primeirasM5_label,
                      valoresPainel1_botao2Maioria_3primeirasM15_label,
                      valoresPainel1_botao2Maioria_3meioM1_label,
                      valoresPainel1_botao2Maioria_3meioM5_label,
                      valoresPainel1_botao2Maioria_3meioM5_altLabel,
                      valoresPainel1_botao2Maioria_3ultimasM1_label,
                      valoresPainel1_botao2Maioria_3ultimasM5_label,
                      valoresPainel1_botao2Maioria_3ultimasM15_label,
                      valoresPainel1_botao3Label,
                      valoresPainel1_botao4Label,
                      valoresPainel1_botao5Label,
                      valoresPainel1_botao8Label,
                      valoresPainel2_entradaLabel,
                      valoresPainel2_quadranteAtual_label,
                      valoresPainel3_botao3Label,
                      valoresPainel3_botao5Label);

   ObjectDelete(0, "statusPainel2");

//--- Deletar Comentários na Tela Principal
   Comment("");
  }

//+------------------------------------------------------------------+
//| ON TICK (FUNÇÃO DE TICK)                                         |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
  }

//+------------------------------------------------------------------+
//| ON TIMER (FUNÇÃO DE TIMER)                                       |
//+------------------------------------------------------------------+
void OnTimer()
  {
//+------------------------------------------------------------------+
//| TEMPO                                                            |
//+------------------------------------------------------------------+
//--- Horários Para Estruturas e Estruturas Para Variáveis
   TimeToStruct(TimeLocal(), horarioLocal_estrutura);

   TimeToStruct(TimeCurrent(), horarioAtual_estrutura);

   diaSemana = horarioAtual_estrutura.day_of_week;

   TimeToStruct(DefinirHorario(diaSemana), horarioDefinido_estrutura);

//--- Formata e Ajusta os Horários Selecionados
   horarioInicio_formatado = FormatarHorario(horarioDefinido_estrutura.year, horarioDefinido_estrutura.mon, horarioDefinido_estrutura.day, horarioInicio_concatenado, diaAnterior_inicioVar);

   horarioOperacoes_formatado = FormatarHorario(horarioDefinido_estrutura.year, horarioDefinido_estrutura.mon, horarioDefinido_estrutura.day, horarioOperacoes_concatenado, diaAnterior_inicioVar);

   horarioFim_formatado = FormatarHorario(horarioDefinido_estrutura.year, horarioDefinido_estrutura.mon, horarioDefinido_estrutura.day, horarioFim_concatenado, diaAnterior_fimVar);

//--- Ajusta os Horário Básicos Excluindo Fins de Semana
   TimeToStruct(horarioInicio_formatado, horarioInicio_estrutura);
   TimeToStruct(horarioOperacoes_formatado, horarioOperacoes_estrutura);
   TimeToStruct(horarioFim_formatado, horarioFim_estrutura);

   switch(horarioInicio_estrutura.day_of_week)
     {
      case  0:
         horarioInicio_formatado = horarioInicio_formatado - 172800;
         break;
      case 6:
         horarioInicio_formatado = horarioInicio_formatado - 86400;
         break;
     }

   switch(horarioOperacoes_estrutura.day_of_week)
     {
      case  0:
         horarioOperacoes_formatado = horarioOperacoes_formatado - 172800;
         break;
      case 6:
         horarioOperacoes_formatado = horarioOperacoes_formatado - 86400;
         break;
     }

   switch(horarioFim_estrutura.day_of_week)
     {
      case  0:
         horarioFim_formatado = horarioFim_formatado - 172800;
         break;
      case 6:
         horarioFim_formatado = horarioFim_formatado - 86400;
         break;
     }

//--- Estabelece Variáveis Básicas de Tempo
   if(Period() == PERIOD_M1)
     {
      decrescimoSegundos_quadrante = 300;
     }
   else
      if(Period() == PERIOD_M5)
        {
         decrescimoSegundos_quadrante = 1800;
        }
      else
         if(Period() == PERIOD_M15)
           {
            decrescimoSegundos_quadrante = 3600;
           }

   velasPor_quadrante = DefinirQuadrante(Period());
   decrescimoMinutos = DefinirDecrescimo_Minutos(velasPor_quadrante);
   decrescimoSegundos= decrescimoMinutos * 60;

   Comment("");
   horarioNegociacao = VerificarHorario_Negociacao(horarioDefinido_estrutura.hour, horaInicio_operacoes, horaFim, horarioDefinido_estrutura.min, minutoInicio_operacoes, minutoFim, horarioLocal_estrutura, decrescimoMinutos * velasPor_quadrante);

//--- Condição para Estabelecer Variáveis de Acordo com o Horário da Corretora
   datetime    horarioCorrente_concatenado = StringToTime(IntegerToString(horarioAtual_estrutura.hour) + ":" + IntegerToString(horarioAtual_estrutura.min / velasPor_quadrante * velasPor_quadrante));

   AjustarHorario(diaSemana, horarioCorrente_concatenado);

//--- INTERESSANTE, EXISTE APENAS PARA FILTRAGEM DE ANOMALIAS
   if((horarioCorrente_concatenado < horarioInicio_formatado) && (horarioCorrente_concatenado < horarioFim_formatado))
     {
      horarioInicio_formatado = horarioInicio_formatado - 86400;
      horarioOperacoes_formatado = horarioOperacoes_formatado - 86400;
      horarioFim_formatado = horarioFim_formatado - 86400;
     }

//+------------------------------------------------------------------+
//| VELAS                                                            |
//+------------------------------------------------------------------+
//--- Corrije Anomalias no Início
   FiltrarCopia_TempoAnomalias(horarioInicio_formatado, horarioFim_formatado - decrescimoSegundos, dadosVelas);
   FiltrarCopia_TempoUsuario(dadosVelas, 1, 5, horaInicio_analise, horaFim, minutoInicio_analise, minutoFim, decrescimoMinutos);

   if(TimeCurrent() > horarioOperacoes_formatado - (decrescimoSegundos_quadrante * katanaBarreira))
     {
      FiltrarCopia_TempoAnomalias(horarioOperacoes_formatado - (decrescimoSegundos_quadrante * katanaBarreira), horarioFim_formatado - decrescimoSegundos, dadosVelas_horarioNegociacao);
      TimeToStruct(dadosVelas_horarioNegociacao[0].time, ajusteFino_horarioEstrutura);
      FiltrarCopia_TempoUsuario(dadosVelas_horarioNegociacao, 1, 5, ajusteFino_horarioEstrutura.hour, horaFim, ajusteFino_horarioEstrutura.min, minutoFim, decrescimoMinutos);
     }

//--- Direção dos Velas (Bulish / Bearish / Doji)
   DefinirDirecao_Velas(direcaoVelas, ArrayRange(dadosVelas, 0), dadosVelas);
   DefinirDirecao_Velas(direcaoVelas_horarioNegociacao, ArrayRange(dadosVelas_horarioNegociacao, 0), dadosVelas_horarioNegociacao);

   numeroLinhas = ArraySize(direcaoVelas) / velasPor_quadrante;
   numeroLinhas_horarioNegociacao = ArraySize(direcaoVelas_horarioNegociacao)/ velasPor_quadrante;

   if(velasPor_quadrante == 5)
     {
      PreencherQuadrante_InteiroM1(numeroLinhas, velasPor_quadrante, direcaoVelas, quadranteVelas_5);
      PreencherQuadrante_DataM1(numeroLinhas, velasPor_quadrante, dadosVelas, periodoVelas_quadrante5);
      PreencherQuadrante_InteiroM1(numeroLinhas_horarioNegociacao, velasPor_quadrante, direcaoVelas_horarioNegociacao, quadranteVelas_5horarioNegociacao);
      PreencherQuadrante_DataM1(numeroLinhas_horarioNegociacao, velasPor_quadrante, dadosVelas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao);
      ContarVelas_QuadranteM1(numeroLinhas, velasPor_quadrante, quadranteVelas_5, velasVerdes_quadrante, velasVermelhas_quadrante, dojisQuadrante);
      ContarVelas_QuadranteM1(numeroLinhas_horarioNegociacao, velasPor_quadrante, quadranteVelas_5horarioNegociacao, velasVerdes_quadranteHorario_negociacao, velasVermelhas_quadranteHorario_negociacao, dojisQuadrante_horarioNegociacao);
     }
   else
      if(velasPor_quadrante == 6)
        {
         PreencherQuadrante_InteiroM5(numeroLinhas, velasPor_quadrante, direcaoVelas, quadranteVelas_6);
         PreencherQuadrante_DataM5(numeroLinhas, velasPor_quadrante, dadosVelas, periodoVelas_quadrante6);
         PreencherQuadrante_InteiroM5(numeroLinhas_horarioNegociacao, velasPor_quadrante, direcaoVelas_horarioNegociacao, quadranteVelas_6horarioNegociacao);
         PreencherQuadrante_DataM5(numeroLinhas_horarioNegociacao, velasPor_quadrante, dadosVelas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao);
         ContarVelas_QuadranteM5(numeroLinhas, velasPor_quadrante, quadranteVelas_6, velasVerdes_quadrante, velasVermelhas_quadrante, dojisQuadrante);
         ContarVelas_QuadranteM5(numeroLinhas_horarioNegociacao, velasPor_quadrante, quadranteVelas_6horarioNegociacao, velasVerdes_quadranteHorario_negociacao, velasVermelhas_quadranteHorario_negociacao, dojisQuadrante_horarioNegociacao);
        }
      else
         if(velasPor_quadrante == 4)
           {
            PreencherQuadrante_InteiroM15(numeroLinhas, velasPor_quadrante, direcaoVelas, quadranteVelas_4);
            PreencherQuadrante_DataM15(numeroLinhas, velasPor_quadrante, dadosVelas, periodoVelas_quadrante4);
            PreencherQuadrante_InteiroM15(numeroLinhas_horarioNegociacao, velasPor_quadrante, direcaoVelas_horarioNegociacao, quadranteVelas_4horarioNegociacao);
            PreencherQuadrante_DataM15(numeroLinhas_horarioNegociacao, velasPor_quadrante, dadosVelas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao);
            ContarVelas_QuadranteM15(numeroLinhas, velasPor_quadrante, quadranteVelas_4, velasVerdes_quadrante, velasVermelhas_quadrante, dojisQuadrante);
            ContarVelas_QuadranteM15(numeroLinhas_horarioNegociacao, velasPor_quadrante, quadranteVelas_4horarioNegociacao, velasVerdes_quadranteHorario_negociacao, velasVermelhas_quadranteHorario_negociacao, dojisQuadrante_horarioNegociacao);
           }

//--- Preenchimento dos Grupos de Três e Contagem de Velas Por Grupo de Três
   PrepararMatriz_InteiroTres(numeroLinhas, tresPrimeiras);
   PrepararMatriz_InteiroTres(numeroLinhas, tresMeio);
   PrepararMatriz_InteiroTres(numeroLinhas, tresMeio_M5alt);
   PrepararMatriz_InteiroTres(numeroLinhas, tresUltimas);
   PrepararMatriz_InteiroTres(numeroLinhas_horarioNegociacao, tresPrimeiras_horarioNegociacao);
   PrepararMatriz_InteiroTres(numeroLinhas_horarioNegociacao, tresMeio_horarioNegociacao);
   PrepararMatriz_InteiroTres(numeroLinhas_horarioNegociacao, tresMeio_M5altHorario_negociacao);
   PrepararMatriz_InteiroTres(numeroLinhas_horarioNegociacao, tresUltimas_horarioNegociacao);

   if(velasPor_quadrante == 4)
     {
      CopiarMatriz_QuatroTres(numeroLinhas, tresPrimeiras, quadranteVelas_4, 0);
      CopiarMatriz_QuatroTres(numeroLinhas, tresUltimas, quadranteVelas_4, 1);
      ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresPrimeiras, velasVerdes_tresPrimeiras, velasVermelhas_tresPrimeiras, dojisPrimeiras_tres);
      ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresUltimas, velasVerdes_tresUltimas, velasVermelhas_tresUltimas, dojisUltimas_tres);
      CopiarMatriz_QuatroTres(numeroLinhas_horarioNegociacao, tresPrimeiras_horarioNegociacao, quadranteVelas_4horarioNegociacao, 0);
      CopiarMatriz_QuatroTres(numeroLinhas_horarioNegociacao, tresUltimas_horarioNegociacao, quadranteVelas_4horarioNegociacao, 1);
      ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresPrimeiras_horarioNegociacao, velasVerdes_tresPrimeiras_horarioNegociacao, velasVermelhas_tresPrimeiras_horarioNegociacao, dojisPrimeiras_tresHorario_negociacao);
      ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresUltimas_horarioNegociacao, velasVerdes_tresUltimas_horarioNegociacao, velasVermelhas_tresUltimas_horarioNegociacao, dojisUltimas_tresHorario_negociacao);
     }
   else
      if(velasPor_quadrante == 5)
        {
         CopiarMatriz_CincoTres(numeroLinhas, tresPrimeiras, quadranteVelas_5, 0);
         CopiarMatriz_CincoTres(numeroLinhas, tresMeio, quadranteVelas_5, 1);
         CopiarMatriz_CincoTres(numeroLinhas, tresUltimas, quadranteVelas_5, 2);
         ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresPrimeiras, velasVerdes_tresPrimeiras, velasVermelhas_tresPrimeiras, dojisPrimeiras_tres);
         ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresMeio, velasVerdes_tresMeio, velasVermelhas_tresMeio, dojisMeio_tres);
         ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresUltimas, velasVerdes_tresUltimas, velasVermelhas_tresUltimas, dojisUltimas_tres);
         CopiarMatriz_CincoTres(numeroLinhas_horarioNegociacao, tresPrimeiras_horarioNegociacao, quadranteVelas_5horarioNegociacao, 0);
         CopiarMatriz_CincoTres(numeroLinhas_horarioNegociacao, tresMeio_horarioNegociacao, quadranteVelas_5horarioNegociacao, 1);
         CopiarMatriz_CincoTres(numeroLinhas_horarioNegociacao, tresUltimas_horarioNegociacao, quadranteVelas_5horarioNegociacao, 2);
         ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresPrimeiras_horarioNegociacao, velasVerdes_tresPrimeiras_horarioNegociacao, velasVermelhas_tresPrimeiras_horarioNegociacao, dojisPrimeiras_tresHorario_negociacao);
         ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresMeio_horarioNegociacao, velasVerdes_tresMeio_horarioNegociacao, velasVermelhas_tresMeio_horarioNegociacao, dojisMeio_tresHorario_negociacao);
         ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresUltimas_horarioNegociacao, velasVerdes_tresUltimas_horarioNegociacao, velasVermelhas_tresUltimas_horarioNegociacao, dojisUltimas_tresHorario_negociacao);
        }
      else
         if(velasPor_quadrante == 6)
           {
            CopiarMatriz_SeisTres(numeroLinhas, tresPrimeiras, quadranteVelas_6, 0);
            CopiarMatriz_SeisTres(numeroLinhas, tresMeio, quadranteVelas_6, 1);
            CopiarMatriz_SeisTres(numeroLinhas, tresMeio_M5alt, quadranteVelas_6, 2);
            CopiarMatriz_SeisTres(numeroLinhas, tresUltimas, quadranteVelas_6, 3);
            ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresPrimeiras, velasVerdes_tresPrimeiras, velasVermelhas_tresPrimeiras, dojisPrimeiras_tres);
            ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresMeio, velasVerdes_tresMeio, velasVermelhas_tresMeio, dojisMeio_tres);
            ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresMeio_M5alt, velasVerdes_tresMeio_M5alt, velasVermelhas_tresMeio_M5alt, dojisMeio_tresM5Alt);
            ContarVelas_GrupoTres(numeroLinhas, velasPor_quadrante, tresUltimas, velasVerdes_tresUltimas, velasVermelhas_tresUltimas, dojisUltimas_tres);
            CopiarMatriz_SeisTres(numeroLinhas_horarioNegociacao, tresPrimeiras_horarioNegociacao, quadranteVelas_6horarioNegociacao, 0);
            CopiarMatriz_SeisTres(numeroLinhas_horarioNegociacao, tresMeio_horarioNegociacao, quadranteVelas_6horarioNegociacao, 1);
            CopiarMatriz_SeisTres(numeroLinhas_horarioNegociacao, tresMeio_M5altHorario_negociacao, quadranteVelas_6horarioNegociacao, 2);
            CopiarMatriz_SeisTres(numeroLinhas_horarioNegociacao, tresUltimas_horarioNegociacao, quadranteVelas_6horarioNegociacao, 3);
            ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresPrimeiras_horarioNegociacao, velasVerdes_tresPrimeiras_horarioNegociacao, velasVermelhas_tresPrimeiras_horarioNegociacao, dojisPrimeiras_tresHorario_negociacao);
            ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresMeio_horarioNegociacao, velasVerdes_tresMeio_horarioNegociacao, velasVermelhas_tresMeio_horarioNegociacao, dojisMeio_tresHorario_negociacao);
            ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresMeio_M5altHorario_negociacao, velasVerdes_tresMeio_M5altHorario_negociacao, velasVermelhas_tresMeio_M5altHorario_negociacao, dojisMeio_tresM5Alt_horarioNegociacao);
            ContarVelas_GrupoTres(numeroLinhas_horarioNegociacao, velasPor_quadrante, tresUltimas_horarioNegociacao, velasVerdes_tresUltimas_horarioNegociacao, velasVermelhas_tresUltimas_horarioNegociacao, dojisUltimas_tresHorario_negociacao);
           }

//--- Maiorias (Cálculo)
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_primeiras);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_ultimas);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_primeirasHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao);

   if(velasPor_quadrante == 5)
     {
      PrepararMatriz_StringDois(numeroLinhas, maioriaVelas);
      PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meio);
      PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao);
      PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioHorario_negociacao);
      CalcularMaioria_M1(numeroLinhas, maioriaVelas, periodoVelas_quadrante5, velasVerdes_quadrante, velasVermelhas_quadrante, 0);
      CalcularMaioria_M1(numeroLinhas, maioriaTres_primeiras, periodoVelas_quadrante5, velasVerdes_tresPrimeiras, velasVermelhas_tresPrimeiras, 0);
      CalcularMaioria_M1(numeroLinhas, maioriaTres_meio, periodoVelas_quadrante5, velasVerdes_tresMeio, velasVermelhas_tresMeio, 1);
      CalcularMaioria_M1(numeroLinhas, maioriaTres_ultimas, periodoVelas_quadrante5, velasVerdes_tresUltimas, velasVermelhas_tresUltimas, 2);
      CalcularMaioria_M1(numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, velasVerdes_quadranteHorario_negociacao, velasVermelhas_quadranteHorario_negociacao, 0);
      CalcularMaioria_M1(numeroLinhas_horarioNegociacao, maioriaTres_primeirasHorario_negociacao, periodoVelas_quadrante5Horario_negociacao, velasVerdes_tresPrimeiras_horarioNegociacao, velasVermelhas_tresPrimeiras_horarioNegociacao, 0);
      CalcularMaioria_M1(numeroLinhas_horarioNegociacao, maioriaTres_meioHorario_negociacao, periodoVelas_quadrante5Horario_negociacao, velasVerdes_tresMeio_horarioNegociacao, velasVermelhas_tresMeio_horarioNegociacao, 1);
      CalcularMaioria_M1(numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, periodoVelas_quadrante5Horario_negociacao, velasVerdes_tresUltimas_horarioNegociacao, velasVermelhas_tresUltimas_horarioNegociacao, 2);
     }
   else
      if(velasPor_quadrante == 6)
        {
         PrepararMatriz_StringDois(numeroLinhas, maioriaVelas);
         PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meio);
         PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meioM5_alt);
         PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao);
         PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioHorario_negociacao);
         PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioM5_altHorario_negociacao);
         CalcularMaioria_M5(numeroLinhas, maioriaVelas, periodoVelas_quadrante6, velasVerdes_quadrante, velasVermelhas_quadrante, 0);
         CalcularMaioria_M5(numeroLinhas, maioriaTres_primeiras, periodoVelas_quadrante6, velasVerdes_tresPrimeiras, velasVermelhas_tresPrimeiras, 0);
         CalcularMaioria_M5(numeroLinhas, maioriaTres_meio, periodoVelas_quadrante6, velasVerdes_tresMeio, velasVermelhas_tresMeio, 1);
         CalcularMaioria_M5(numeroLinhas, maioriaTres_meioM5_alt, periodoVelas_quadrante6, velasVerdes_tresMeio_M5alt, velasVermelhas_tresMeio_M5alt, 2);
         CalcularMaioria_M5(numeroLinhas, maioriaTres_ultimas, periodoVelas_quadrante6, velasVerdes_tresUltimas, velasVermelhas_tresUltimas, 3);
         CalcularMaioria_M5(numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, velasVerdes_quadranteHorario_negociacao, velasVermelhas_quadranteHorario_negociacao, 0);
         CalcularMaioria_M5(numeroLinhas_horarioNegociacao, maioriaTres_primeirasHorario_negociacao, periodoVelas_quadrante6Horario_negociacao, velasVerdes_tresPrimeiras_horarioNegociacao, velasVermelhas_tresPrimeiras_horarioNegociacao, 0);
         CalcularMaioria_M5(numeroLinhas_horarioNegociacao, maioriaTres_meioHorario_negociacao, periodoVelas_quadrante6Horario_negociacao, velasVerdes_tresMeio_horarioNegociacao, velasVermelhas_tresMeio_horarioNegociacao, 1);
         CalcularMaioria_M5(numeroLinhas_horarioNegociacao, maioriaTres_meioM5_altHorario_negociacao, periodoVelas_quadrante6Horario_negociacao, velasVerdes_tresMeio_M5altHorario_negociacao, velasVermelhas_tresMeio_M5altHorario_negociacao, 2);
         CalcularMaioria_M5(numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, periodoVelas_quadrante6Horario_negociacao, velasVerdes_tresUltimas_horarioNegociacao, velasVermelhas_tresUltimas_horarioNegociacao, 3);
        }
      else
         if(velasPor_quadrante == 4)
           {
            PrepararMatriz_StringDois(numeroLinhas, maioriaVelas);
            PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao);
            CalcularMaioria_M15(numeroLinhas, maioriaVelas, periodoVelas_quadrante4, velasVerdes_quadrante, velasVermelhas_quadrante, 0);
            CalcularMaioria_M15(numeroLinhas, maioriaTres_primeiras, periodoVelas_quadrante4, velasVerdes_tresPrimeiras, velasVermelhas_tresPrimeiras, 0);
            CalcularMaioria_M15(numeroLinhas, maioriaTres_ultimas, periodoVelas_quadrante4, velasVerdes_tresUltimas, velasVermelhas_tresUltimas, 1);
            CalcularMaioria_M15(numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, velasVerdes_quadranteHorario_negociacao, velasVermelhas_quadranteHorario_negociacao, 0);
            CalcularMaioria_M15(numeroLinhas_horarioNegociacao, maioriaTres_primeirasHorario_negociacao, periodoVelas_quadrante4Horario_negociacao, velasVerdes_tresPrimeiras_horarioNegociacao, velasVermelhas_tresPrimeiras_horarioNegociacao, 0);
            CalcularMaioria_M15(numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, periodoVelas_quadrante4Horario_negociacao, velasVerdes_tresUltimas_horarioNegociacao, velasVermelhas_tresUltimas_horarioNegociacao, 1);
           }

//--- Quadrante Atual (Checagem de Horário)
   if(velasPor_quadrante == 5)
     {
      velaAtual = ChecarHorario_QuadranteAtual_M1(horarioLocal_estrutura.min);
     }
   else
      if(velasPor_quadrante == 6)
        {
         velaAtual = ChecarHorario_QuadranteAtual_M5(horarioLocal_estrutura.min);
        }
      else
         if(velasPor_quadrante == 4)
           {
            velaAtual = ChecarHorario_QuadranteAtual_M15(horarioLocal_estrutura.min);
           }

//--- Quadrante Atual (Preenchimento)
   if(velasPor_quadrante == 5)
     {
      PrepararVetor_Inteiro(4, direcaoVelas_quadranteAtual);
     }
   else
      if(velasPor_quadrante == 6)
        {
         PrepararVetor_Inteiro(5, direcaoVelas_quadranteAtual);
        }
      else
         if(velasPor_quadrante == 4)
           {
            PrepararVetor_Inteiro(3, direcaoVelas_quadranteAtual);
           }

   if(velaAtual == 0)
     {
      ArrayResize(dadosVelas_quadranteAtual, 1, 0);
      dadosVelas_quadranteAtual[0].time = TimeCurrent();
      dadosVelas_quadranteAtual[0].open = iOpen(Symbol(), Period(), 0);
      dadosVelas_quadranteAtual[0].close = SymbolInfoTick(Symbol(), precoAtual_estrutura);
      DefinirDirecao_Velas(direcaoVelas_quadranteAtual, 1, dadosVelas_quadranteAtual);
     }
   else
      if(velaAtual == 1)
        {
         CopyRates(Symbol(), Period(), 1, 1, dadosVelas_quadranteAtual);
         DefinirDirecao_Velas(direcaoVelas_quadranteAtual, 1, dadosVelas_quadranteAtual);
        }
      else
         if(velaAtual == 2)
           {
            CopyRates(Symbol(), Period(), 1, 2, dadosVelas_quadranteAtual);
            DefinirDirecao_Velas(direcaoVelas_quadranteAtual, 2, dadosVelas_quadranteAtual);
           }
         else
            if(velaAtual == 3)
              {
               CopyRates(Symbol(), Period(), 1, 3, dadosVelas_quadranteAtual);
               DefinirDirecao_Velas(direcaoVelas_quadranteAtual, 3, dadosVelas_quadranteAtual);
              }
            else
               if(velaAtual == 4)
                 {
                  CopyRates(Symbol(), Period(), 1, 4, dadosVelas_quadranteAtual);
                  DefinirDirecao_Velas(direcaoVelas_quadranteAtual, 4, dadosVelas_quadranteAtual);
                 }
               else
                  if(velaAtual == 5)
                    {
                     CopyRates(Symbol(), Period(), 1, 5, dadosVelas_quadranteAtual);
                     DefinirDirecao_Velas(direcaoVelas_quadranteAtual, 5, dadosVelas_quadranteAtual);
                    }

//--- Quadrante Atual (Zerar Variáveis)
   if(velaAtual == 0)
     {
      Zerar12Variaveis(velasVerdes_quadranteAtual, velasVermelhas_quadranteAtual, dojisQuadrante_atual, velasVerdes_tresPrimeiras_quadranteAtual,
                       velasVermelhas_tresPrimeiras_quadranteAtual, dojisPrimeiras_tresQuadrante_atual, velasVerdes_tresMeio_quadranteAtual,
                       velasVermelhas_tresMeio_quadranteAtual, dojisMeio_tresQuadrante_atual, velasVerdes_tresMeio_M5alt_quadranteAtual,
                       velasVermelhas_tresMeio_M5alt_quadranteAtual, dojisMeio_tresM5alt_quadranteAtual);
     }
//--- Quadrante Atual (Calcular Maiorias)
   else
      if(velaAtual != 0)
        {
         ContarVelas_QuadranteAtual(direcaoVelas_quadranteAtual, velasVerdes_quadranteAtual, velasVermelhas_quadranteAtual, dojisQuadrante_atual);
         CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaVelas_quadranteAtual, velasVerdes_quadranteAtual, velasVermelhas_quadranteAtual);
         if(velaAtual == 3 || velaAtual == 4 || velaAtual == 5)
           {
            ContarVelas_Variavel3Primeiras(direcaoVelas_quadranteAtual, velasVerdes_tresPrimeiras_quadranteAtual, velasVermelhas_tresPrimeiras_quadranteAtual, dojisPrimeiras_tresQuadrante_atual);
            CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaTres_primeirasQuadrante_atual, velasVerdes_tresPrimeiras_quadranteAtual, velasVermelhas_tresPrimeiras_quadranteAtual);
           }
         if(velaAtual == 4 || velaAtual == 5)
           {
            ContarVelas_Variavel3Meio(direcaoVelas_quadranteAtual, velasVerdes_tresMeio_quadranteAtual, velasVermelhas_tresMeio_quadranteAtual, dojisMeio_tresQuadrante_atual);
            CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaTres_meioQuadrante_atual, velasVerdes_tresMeio_quadranteAtual, velasVermelhas_tresMeio_quadranteAtual);
           }
         if(velaAtual == 5)
           {
            ContarVelas_Variavel3Meio_M5Alt(direcaoVelas_quadranteAtual, velasVerdes_tresMeio_M5alt_quadranteAtual, velasVermelhas_tresMeio_M5alt_quadranteAtual, dojisMeio_tresM5alt_quadranteAtual);
            CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaTres_meioM5_altQuadrante_atual, velasVerdes_tresMeio_M5alt_quadranteAtual, velasVermelhas_tresMeio_M5alt_quadranteAtual);
           }
        }

//--- Contagem dos Velas por Tipo
   ContarVelas(direcaoVelas, velasVerdes, velasVermelhas, dojis);
   velasVerdes_total = velasVerdes + velasVerdes_quadranteAtual;
   velasVermelhas_total = velasVermelhas + velasVermelhas_quadranteAtual;
   if(horarioNegociacao == true)
     {
      dojisTotal = dojis + dojisQuadrante_atual;
     }
   else
     {
      ZeroMemory(dojisQuadrante_atual);
      dojisTotal = dojis;
     }

//--- Porcentagem de Velas Verdes VS Velas Vermelhas
   velasVerdes_porcentagem = VerificarPorcentagem_TresElementos(velasVerdes_total, velasVermelhas_total, dojisTotal);
   velasVermelhas_porcentagem = VerificarPorcentagem_TresElementos(velasVermelhas_total, velasVerdes_total, dojisTotal);
   dojisPorcentagem = VerificarPorcentagem_TresElementos(dojisTotal, velasVerdes_total, velasVermelhas_total);

//--- Quadrante Complementar (Checagem de Horário)
   acrescimoSegundos_quadranteComplementar = DefinirAcrescimo_SegundosComplementares(velasPor_quadrante);

   if(velasPor_quadrante == 6 && (horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 6))
     {
      velaComplementar = 6;
     }
   else
      if((velasPor_quadrante == 6 && (horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 5 && horarioCorrente_concatenado < horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 6)) ||
         (velasPor_quadrante == 5 && horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 5))
        {
         velaComplementar = 5;
        }
      else
         if(((velasPor_quadrante == 6 || velasPor_quadrante == 5) && horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 4 && horarioCorrente_concatenado < horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 5) ||
            (velasPor_quadrante == 4 && horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 4))
           {
            velaComplementar = 4;
           }
         else
            if(horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 3 && horarioCorrente_concatenado < horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 4)
              {
               velaComplementar = 3;
              }
            else
               if(horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 2 && horarioCorrente_concatenado < horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 3)
                 {
                  velaComplementar = 2;
                 }
               else
                  if(horarioCorrente_concatenado >= horarioFim_formatado + acrescimoSegundos_quadranteComplementar && horarioCorrente_concatenado < horarioFim_formatado + acrescimoSegundos_quadranteComplementar)
                    {
                     velaComplementar = 1;
                    }
                  else
                    {
                     velaComplementar = 0;
                    }

//--- Checa Existência de Qualquer Vela Complementar
   if(velaComplementar > 0)
     {
      quadranteComplementar_qualquerVela = true;
     }

//--- Quadrante Complementar (Preenchimento)
   if(velaComplementar == 1)
     {
      PrepararVetor_Inteiro(1, direcaoVelas_quadranteComplementar);
      CopyRates(Symbol(), Period(), 0, 1, dadosVelas_quadranteComplementar);
      DefinirDirecao_Velas(direcaoVelas_quadranteComplementar, 1, dadosVelas_quadranteComplementar);
     }
   else
      if(velaComplementar == 2)
        {
         PrepararVetor_Inteiro(2, direcaoVelas_quadranteComplementar);
         CopyRates(Symbol(), Period(), horarioFim_formatado, horarioFim_formatado + acrescimoSegundos_quadranteComplementar, dadosVelas_quadranteComplementar);
         DefinirDirecao_Velas(direcaoVelas_quadranteComplementar, 2, dadosVelas_quadranteComplementar);
        }
      else
         if(velaComplementar == 3)
           {
            PrepararVetor_Inteiro(3, direcaoVelas_quadranteComplementar);
            CopyRates(Symbol(), Period(), horarioFim_formatado, horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 2, dadosVelas_quadranteComplementar);
            DefinirDirecao_Velas(direcaoVelas_quadranteComplementar, 3, dadosVelas_quadranteComplementar);
           }
         else
            if(velaComplementar == 4)
              {
               PrepararVetor_Inteiro(4, direcaoVelas_quadranteComplementar);
               CopyRates(Symbol(), Period(), horarioFim_formatado, horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 3, dadosVelas_quadranteComplementar);
               DefinirDirecao_Velas(direcaoVelas_quadranteComplementar, 4, dadosVelas_quadranteComplementar);
              }
            else
               if(velaComplementar == 5 && (velasPor_quadrante == 5 || velasPor_quadrante == 6))
                 {
                  PrepararVetor_Inteiro(5, direcaoVelas_quadranteComplementar);
                  CopyRates(Symbol(), Period(), horarioFim_formatado, horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 4, dadosVelas_quadranteComplementar);
                  DefinirDirecao_Velas(direcaoVelas_quadranteComplementar, 5, dadosVelas_quadranteComplementar);
                 }
               else
                  if(velaComplementar == 6 && velasPor_quadrante == 6)
                    {
                     PrepararVetor_Inteiro(6, direcaoVelas_quadranteComplementar);
                     CopyRates(Symbol(), Period(), horarioFim_formatado, horarioFim_formatado + acrescimoSegundos_quadranteComplementar * 5, dadosVelas_quadranteComplementar);
                     DefinirDirecao_Velas(direcaoVelas_quadranteComplementar, 6, dadosVelas_quadranteComplementar);
                    }

//+------------------------------------------------------------------+
//| ESTRATÉGIAS DE UMA (1) POSIÇÃO                                   |
//+------------------------------------------------------------------+
   PrepararMatriz_StringDois(numeroLinhas, umPara2_PDR);
   PrepararMatriz_StringDois(numeroLinhas, doisPara3_PDR);
   PrepararMatriz_StringDois(numeroLinhas, tresPara4_PDR);
   PrepararMatriz_StringDois(numeroLinhas, quatroPara1_PDR);
   PrepararMatriz_StringDois(numeroLinhas, quatroPara5_PDR);
   PrepararMatriz_StringDois(numeroLinhas, cincoPara1_PDR);
   PrepararMatriz_StringDois(numeroLinhas, cincoPara6_PDR);
   PrepararMatriz_StringDois(numeroLinhas, seisPara1_PDR);
   PrepararMatriz_StringDois(numeroLinhas, maioriaVelas_para1PDR);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_primeirasPara4_PDR);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meioPara5_PDR);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meioM5_altPara6_PDR);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_ultimasPara1_PDR);
   PrepararMatriz_StringDois(numeroLinhas, umPara2_INV);
   PrepararMatriz_StringDois(numeroLinhas, doisPara3_INV);
   PrepararMatriz_StringDois(numeroLinhas, tresPara4_INV);
   PrepararMatriz_StringDois(numeroLinhas, quatroPara1_INV);
   PrepararMatriz_StringDois(numeroLinhas, quatroPara5_INV);
   PrepararMatriz_StringDois(numeroLinhas, cincoPara1_INV);
   PrepararMatriz_StringDois(numeroLinhas, cincoPara6_INV);
   PrepararMatriz_StringDois(numeroLinhas, seisPara1_INV);
   PrepararMatriz_StringDois(numeroLinhas, maioriaVelas_para1INV);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_primeirasPara4_INV);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meioPara5_INV);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_meioM5_altPara6_INV);
   PrepararMatriz_StringDois(numeroLinhas, maioriaTres_ultimasPara1_INV);

   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, umPara2_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, doisPara3_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, tresPara4_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, quatroPara1_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, quatroPara5_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, cincoPara1_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, cincoPara6_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, seisPara1_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaVelas_para1PDR_horarioNegociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_primeirasPara4_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioPara5_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioM5_altPara6_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_ultimasPara1_PDRHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, umPara2_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, doisPara3_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, tresPara4_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, quatroPara1_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, quatroPara5_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, cincoPara1_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, cincoPara6_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, seisPara1_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaVelas_para1INV_horarioNegociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_primeirasPara4_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioPara5_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_meioM5_altPara6_INVHorario_negociacao);
   PrepararMatriz_StringDois(numeroLinhas_horarioNegociacao, maioriaTres_ultimasPara1_INVHorario_negociacao);

   if(velasPor_quadrante == 5)
     {
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 0, umPara2_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 1, doisPara3_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 2, tresPara4_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 3, quatroPara5_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 4, cincoPara1_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas, quadranteVelas_5, maioriaVelas, 4, maioriaVelas_para1PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas, quadranteVelas_5, maioriaTres_primeiras, 2, maioriaTres_primeirasPara4_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas, quadranteVelas_5, maioriaTres_meio, 3, maioriaTres_meioPara5_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas, quadranteVelas_5, maioriaTres_ultimas, 4, maioriaTres_ultimasPara1_PDR, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 0, umPara2_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 1, doisPara3_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 2, tresPara4_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 3, quatroPara5_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_PDRM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 4, cincoPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaVelas_horarioNegociacao, 4, maioriaVelas_para1PDR_horarioNegociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaTres_primeirasHorario_negociacao, 2, maioriaTres_primeirasPara4_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaTres_meioHorario_negociacao, 3, maioriaTres_meioPara5_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_PDRM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, 4, maioriaTres_ultimasPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 0, umPara2_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 1, doisPara3_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 2, tresPara4_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 3, quatroPara5_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas, periodoVelas_quadrante5, quadranteVelas_5, 4, cincoPara1_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas, quadranteVelas_5, maioriaVelas, 4, maioriaVelas_para1INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas, quadranteVelas_5, maioriaTres_primeiras, 2, maioriaTres_primeirasPara4_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas, quadranteVelas_5, maioriaTres_meio, 3, maioriaTres_meioPara5_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas, quadranteVelas_5, maioriaTres_ultimas, 4, maioriaTres_ultimasPara1_INV, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 0, umPara2_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 1, doisPara3_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 2, tresPara4_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 3, quatroPara5_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaFluxo_INVM1(numeroLinhas_horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteVelas_5horarioNegociacao, 4, cincoPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaVelas_horarioNegociacao, 4, maioriaVelas_para1INV_horarioNegociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaTres_primeirasHorario_negociacao, 2, maioriaTres_primeirasPara4_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaTres_meioHorario_negociacao, 3, maioriaTres_meioPara5_INVHorario_negociacao, posicoes, metodoPosicoes);
      PreencherQuadrante_EstrategiaMaioria_INVM1(numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, 4, maioriaTres_ultimasPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
     }
   else
      if(velasPor_quadrante == 6)
        {
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 0, umPara2_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 1, doisPara3_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 2, tresPara4_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 3, quatroPara5_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 4, cincoPara6_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 5, seisPara1_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas, quadranteVelas_6, maioriaVelas, 5, maioriaVelas_para1PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas, quadranteVelas_6, maioriaTres_primeiras, 2, maioriaTres_primeirasPara4_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas, quadranteVelas_6, maioriaTres_meio, 3, maioriaTres_meioPara5_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas, quadranteVelas_6, maioriaTres_meioM5_alt, 4, maioriaTres_meioM5_altPara6_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas, quadranteVelas_6, maioriaTres_ultimas, 5, maioriaTres_ultimasPara1_PDR, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 0, umPara2_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 1, doisPara3_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 2, tresPara4_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 3, quatroPara5_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 4, cincoPara6_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_PDRM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 5, seisPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaVelas_horarioNegociacao, 5, maioriaVelas_para1PDR_horarioNegociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_primeirasHorario_negociacao, 2, maioriaTres_primeirasPara4_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_meioHorario_negociacao, 3, maioriaTres_meioPara5_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_meioM5_altHorario_negociacao, 4, maioriaTres_meioM5_altPara6_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_PDRM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, 5, maioriaTres_ultimasPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 0, umPara2_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 1, doisPara3_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 2, tresPara4_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 3, quatroPara5_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 4, cincoPara6_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas, periodoVelas_quadrante6, quadranteVelas_6, 5, seisPara1_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas, quadranteVelas_6, maioriaVelas, 5, maioriaVelas_para1INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas, quadranteVelas_6, maioriaTres_primeiras, 2, maioriaTres_primeirasPara4_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas, quadranteVelas_6, maioriaTres_meio, 3, maioriaTres_meioPara5_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas, quadranteVelas_6, maioriaTres_meioM5_alt, 4, maioriaTres_meioM5_altPara6_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas, quadranteVelas_6, maioriaTres_ultimas, 5, maioriaTres_ultimasPara1_INV, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 0, umPara2_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 1, doisPara3_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 2, tresPara4_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 3, quatroPara5_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 4, cincoPara6_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaFluxo_INVM5(numeroLinhas_horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteVelas_6horarioNegociacao, 5, seisPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaVelas_horarioNegociacao, 5, maioriaVelas_para1INV_horarioNegociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_primeirasHorario_negociacao, 2, maioriaTres_primeirasPara4_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_meioHorario_negociacao, 3, maioriaTres_meioPara5_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_meioM5_altHorario_negociacao, 4, maioriaTres_meioM5_altPara6_INVHorario_negociacao, posicoes, metodoPosicoes);
         PreencherQuadrante_EstrategiaMaioria_INVM5(numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, 5, maioriaTres_ultimasPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
        }
      else
         if(velasPor_quadrante == 4)
           {
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 0, umPara2_PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 1, doisPara3_PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 2, tresPara4_PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 3, quatroPara1_PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_PDRM15(numeroLinhas, quadranteVelas_4, maioriaVelas, 3, maioriaVelas_para1PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_PDRM15(numeroLinhas, quadranteVelas_4, maioriaTres_primeiras, 2, maioriaTres_primeirasPara4_PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_PDRM15(numeroLinhas, quadranteVelas_4, maioriaTres_ultimas, 3, maioriaTres_ultimasPara1_PDR, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 0, umPara2_PDRHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 1, doisPara3_PDRHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 2, tresPara4_PDRHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_PDRM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 3, quatroPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_PDRM15(numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, maioriaVelas_horarioNegociacao, 3, maioriaVelas_para1PDR_horarioNegociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_PDRM15(numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, maioriaTres_primeirasHorario_negociacao, 2, maioriaTres_primeirasPara4_PDRHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_PDRM15(numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, 3, maioriaTres_ultimasPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 0, umPara2_INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 1, doisPara3_INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 2, tresPara4_INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas, periodoVelas_quadrante4, quadranteVelas_4, 3, quatroPara1_INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_INVM15(numeroLinhas, quadranteVelas_4, maioriaVelas, 3, maioriaVelas_para1INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_INVM15(numeroLinhas, quadranteVelas_4, maioriaTres_primeiras, 2, maioriaTres_primeirasPara4_INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_INVM15(numeroLinhas, quadranteVelas_4, maioriaTres_ultimas, 3, maioriaTres_ultimasPara1_INV, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 0, umPara2_INVHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 1, doisPara3_INVHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 2, tresPara4_INVHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaFluxo_INVM15(numeroLinhas_horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteVelas_4horarioNegociacao, 3, quatroPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_INVM15(numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, maioriaVelas_horarioNegociacao, 3, maioriaVelas_para1INV_horarioNegociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_INVM15(numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, maioriaTres_primeirasHorario_negociacao, 2, maioriaTres_primeirasPara4_INVHorario_negociacao, posicoes, metodoPosicoes);
            PreencherQuadrante_EstrategiaMaioria_INVM15(numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, 3, maioriaTres_ultimasPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
           }

////+------------------------------------------------------------------+
////| COMPLEMENTAÇÃO DAS ESTRATÉGIAS                                   |
////+------------------------------------------------------------------+
   if(quadranteComplementar_qualquerVela == true)
     {
      CopiarVetor_Inteiro(quadranteAcrescimo_definitivo, direcaoVelas_quadranteComplementar);

      if(velaComplementar == 0)
        {
         Zerar12Variaveis(velasVerdes_quadranteAtual, velasVermelhas_quadranteAtual, dojisQuadrante_atual, velasVerdes_tresPrimeiras_quadranteAtual,
                          velasVermelhas_tresPrimeiras_quadranteAtual, dojisPrimeiras_tresQuadrante_atual, velasVerdes_tresMeio_quadranteAtual,
                          velasVermelhas_tresMeio_quadranteAtual, dojisMeio_tresQuadrante_atual, velasVerdes_tresMeio_M5alt_quadranteAtual,
                          velasVermelhas_tresMeio_M5alt_quadranteAtual, dojisMeio_tresM5alt_quadranteAtual);
        }
      //--- Quadrante Atual (Calcular Maiorias)
      else
         if(velaComplementar != 0)
           {
            ContarVelas_QuadranteAtual(direcaoVelas_quadranteComplementar, velasVerdes_quadranteComplementar, velasVermelhas_quadranteComplementar, dojisQuadrante_complementar);
            CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaVelas_quadranteComplementar, velasVerdes_quadranteComplementar, velasVermelhas_quadranteComplementar);
            if(velaComplementar >= 3)
              {
               ContarVelas_Variavel3Primeiras(direcaoVelas_quadranteComplementar, velasVerdes_tresPrimeiras_quadranteComplementar, velasVermelhas_tresPrimeiras_quadranteComplementar, dojisPrimeiras_tresQuadrante_complementar);
               CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaTres_primeirasQuadrante_complementar, velasVerdes_tresPrimeiras_quadranteComplementar, velasVermelhas_tresPrimeiras_quadranteComplementar);
              }
            if(velaComplementar >= 4)
              {
               ContarVelas_Variavel3Meio(direcaoVelas_quadranteComplementar, velasVerdes_tresMeio_quadranteComplementar, velasVermelhas_tresMeio_quadranteComplementar, dojisMeio_tresQuadrante_complementar);
               CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaTres_meioQuadrante_complementar, velasVerdes_tresMeio_quadranteComplementar, velasVermelhas_tresMeio_quadranteComplementar);
              }
            if(velaComplementar >= 5)
              {
               ContarVelas_Variavel3Meio_M5Alt(direcaoVelas_quadranteComplementar, velasVerdes_tresMeio_M5alt_quadranteComplementar, velasVermelhas_tresMeio_M5alt_quadranteComplementar, dojisMeio_tresM5alt_quadranteComplementar);
               CalcularMaioria_QuadranteAtual(numeroLinhas, maioriaTres_meioM5_altQuadrante_complementar, velasVerdes_tresMeio_M5alt_quadranteComplementar, velasVermelhas_tresMeio_M5alt_quadranteComplementar);
              }
           }
     }
   else
      if(velaAtual != 0)
        {
         CopiarVetor_Inteiro(quadranteAcrescimo_definitivo, direcaoVelas_quadranteAtual);
        }
      else
        {
         PrepararVetor_Inteiro(5, quadranteAcrescimo_definitivo);
        }

//--- Checagem de Complementação de Acordo com Estratégia Adotada

   if((metodoPosicoes == 1 && ((posicoes == 1 && velaAtual >= 1) ||
                               (posicoes == 2 && velaAtual >= 2) ||
                               (posicoes == 3 && velaAtual >= 3))) ||
      (metodoPosicoes == 2 && velaAtual >= 1))
     {
      quadranteAcrescimo_definitivoChecado = true;
     }
   else
     {
      quadranteAcrescimo_definitivoChecado = false;
     }

//--- PROBLEMA DE COMPLEMENTAÇÃO QUANDO HÁ MAIS DE UMA POSIÇÃO (NÃO ESQUECER 4 = 5 ou 1 por exemplo)
//--- Complementação de Fato das Estratégias
   if(horarioNegociacao == true && TimeCurrent() > horarioOperacoes_formatado + 5)
     {
      if(velasPor_quadrante == 5)
        {
         //ComplementarEstrategia_FluxoPDR_M1(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 2, 0, tresPara4_PDR, posicoes, metodoPosicoes);
         //ComplsementarEstrategia_FluxoPDR_M1(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 3, 0, quatroPara5_PDR, posicoes, metodoPosicoes);
         ComplementarEstrategia_FluxoPDR_M1(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 4, 0, cincoPara1_PDR, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaPDR_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaVelas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1PDR, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaPDR_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaTres_ultimas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 2, 0, maioriaTres_ultimasPara1_PDR, posicoes, metodoPosicoes);
         ComplementarEstrategia_FluxoPDR_M1(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteAcrescimo_definitivo, 4, 0, cincoPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaPDR_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, quadranteVelas_5horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1PDR_horarioNegociacao, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaPDR_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, quadranteVelas_5horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteAcrescimo_definitivo, 2, 0, maioriaTres_ultimasPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
         ComplementarEstrategia_FluxoINV_M1(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 4, 0, cincoPara1_INV, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaINV_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaVelas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1INV, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaINV_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaTres_ultimas, quadranteVelas_5, periodoVelas_quadrante5, quadranteAcrescimo_definitivo, 2, 0, maioriaTres_ultimasPara1_INV, posicoes, metodoPosicoes);
         ComplementarEstrategia_FluxoINV_M1(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas_horarioNegociacao, quadranteVelas_5horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteAcrescimo_definitivo, 4, 0, cincoPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaINV_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, quadranteVelas_5horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1INV_horarioNegociacao, posicoes, metodoPosicoes);
         ComplementarEstrategia_MaioriaINV_M1(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, quadranteVelas_5horarioNegociacao, periodoVelas_quadrante5Horario_negociacao, quadranteAcrescimo_definitivo, 2, 0, maioriaTres_ultimasPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
        }
      else
         if(velasPor_quadrante == 6)
           {
            ComplementarEstrategia_FluxoPDR_M5(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas, quadranteVelas_6, periodoVelas_quadrante6, quadranteAcrescimo_definitivo, 5, 0, seisPara1_PDR, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaPDR_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaVelas, quadranteVelas_6, periodoVelas_quadrante6, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1PDR, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaPDR_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaTres_ultimas, quadranteVelas_6, periodoVelas_quadrante6, quadranteAcrescimo_definitivo, 3, 0, maioriaTres_ultimasPara1_PDR, posicoes, metodoPosicoes);
            ComplementarEstrategia_FluxoPDR_M5(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteAcrescimo_definitivo, 5, 0, seisPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaPDR_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, quadranteVelas_6horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1PDR_horarioNegociacao, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaPDR_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, quadranteVelas_6horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteAcrescimo_definitivo, 3, 0, maioriaTres_ultimasPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
            ComplementarEstrategia_FluxoINV_M5(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas, quadranteVelas_6, periodoVelas_quadrante6, quadranteAcrescimo_definitivo, 5, 0, seisPara1_INV, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaINV_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaVelas, quadranteVelas_6, periodoVelas_quadrante6, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1INV, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaINV_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaTres_ultimas, quadranteVelas_6, periodoVelas_quadrante6, quadranteAcrescimo_definitivo, 3, 0, maioriaTres_ultimasPara1_INV, posicoes, metodoPosicoes);
            ComplementarEstrategia_FluxoINV_M5(quadranteAcrescimo_definitivoChecado, velaAtual, numeroLinhas_horarioNegociacao, quadranteVelas_6horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteAcrescimo_definitivo, 5, 0, seisPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaINV_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, quadranteVelas_6horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1INV_horarioNegociacao, posicoes, metodoPosicoes);
            ComplementarEstrategia_MaioriaINV_M5(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, quadranteVelas_6horarioNegociacao, periodoVelas_quadrante6Horario_negociacao, quadranteAcrescimo_definitivo, 3, 0, maioriaTres_ultimasPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
           }
         else
            if(velasPor_quadrante == 4)
              {
               ComplementarEstrategia_FluxoPDR_M15(quadranteAcrescimo_definitivoChecado,  velaAtual,numeroLinhas, quadranteVelas_4, periodoVelas_quadrante4, quadranteAcrescimo_definitivo, 3, 0, quatroPara1_PDR, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaPDR_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaVelas, quadranteVelas_4, periodoVelas_quadrante4, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1PDR, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaPDR_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaTres_ultimas, quadranteVelas_4, periodoVelas_quadrante4, quadranteAcrescimo_definitivo, 1, 0, maioriaTres_ultimasPara1_PDR, posicoes, metodoPosicoes);
               ComplementarEstrategia_FluxoPDR_M15(quadranteAcrescimo_definitivoChecado,  velaAtual,numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteAcrescimo_definitivo, 3, 0, quatroPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaPDR_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, quadranteVelas_4, periodoVelas_quadrante4Horario_negociacao, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1PDR_horarioNegociacao, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaPDR_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, quadranteVelas_4, periodoVelas_quadrante4Horario_negociacao, quadranteAcrescimo_definitivo, 1, 0, maioriaTres_ultimasPara1_PDRHorario_negociacao, posicoes, metodoPosicoes);
               ComplementarEstrategia_FluxoINV_M15(quadranteAcrescimo_definitivoChecado,  velaAtual,numeroLinhas, quadranteVelas_4, periodoVelas_quadrante4, quadranteAcrescimo_definitivo, 3, 0, quatroPara1_INV, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaINV_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaVelas, quadranteVelas_4, periodoVelas_quadrante4, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1INV, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaINV_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas, maioriaTres_ultimas, quadranteVelas_4, periodoVelas_quadrante4, quadranteAcrescimo_definitivo, 1, 0, maioriaTres_ultimasPara1_INV, posicoes, metodoPosicoes);
               ComplementarEstrategia_FluxoINV_M15(quadranteAcrescimo_definitivoChecado,  velaAtual,numeroLinhas_horarioNegociacao, quadranteVelas_4horarioNegociacao, periodoVelas_quadrante4Horario_negociacao, quadranteAcrescimo_definitivo, 3, 0, quatroPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaINV_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaVelas_horarioNegociacao, quadranteVelas_4, periodoVelas_quadrante4Horario_negociacao, quadranteAcrescimo_definitivo, 0, 0, maioriaVelas_para1INV_horarioNegociacao, posicoes, metodoPosicoes);
               ComplementarEstrategia_MaioriaINV_M15(velaAtual, quadranteComplementar_qualquerVela, numeroLinhas_horarioNegociacao, maioriaTres_ultimasHorarioNegociacao, quadranteVelas_4, periodoVelas_quadrante4Horario_negociacao, quadranteAcrescimo_definitivo, 1, 0, maioriaTres_ultimasPara1_INVHorario_negociacao, posicoes, metodoPosicoes);
              }
     }

//+------------------------------------------------------------------+
//| CÁLCULO DE OCORRÊNCIAS (ESTATÍSTICAS)                            |
//+------------------------------------------------------------------+
   CalcularOcorrencias_PDR(numeroLinhas, umPara2_PDR, umIgual2_ocorrenciasPDR);
   CalcularOcorrencias_PDR(numeroLinhas, doisPara3_PDR, doisIgual3_ocorrenciasPDR);
   CalcularOcorrencias_PDR(numeroLinhas, tresPara4_PDR, tresIgual4_ocorrenciasPDR);
   CalcularOcorrencias_PDR(numeroLinhas, maioriaVelas_para1PDR, maioriaVelas_igual1Ocorrencias_PDR);
   CalcularOcorrencias_PDR(numeroLinhas, maioriaTres_primeirasPara4_PDR, maioriaTres_primeirasIgual4_ocorrenciasPDR);
   CalcularOcorrencias_PDR(numeroLinhas, maioriaTres_ultimasPara1_PDR, maioriaTres_ultimasIgual1_ocorrenciasPDR);
   CalcularOcorrencias_INV(numeroLinhas, umPara2_INV, umDif2_ocorrenciasINV);
   CalcularOcorrencias_INV(numeroLinhas, doisPara3_INV, doisDif3_ocorrenciasINV);
   CalcularOcorrencias_INV(numeroLinhas, tresPara4_INV, tresDif4_ocorrenciasINV);
   CalcularOcorrencias_INV(numeroLinhas, maioriaVelas_para1INV, maioriaVelas_dif1Ocorrencias_INV);
   CalcularOcorrencias_INV(numeroLinhas, maioriaTres_primeirasPara4_INV, maioriaTres_primeirasDif4_ocorrenciasINV);
   CalcularOcorrencias_INV(numeroLinhas, maioriaTres_ultimasPara1_INV, maioriaTres_ultimasDif1_ocorrenciasINV);

//--- Ocorrências Específicas Para Certos Timeframes
   if(velasPor_quadrante == 5)
     {
      CalcularOcorrencias_PDR(numeroLinhas, quatroPara5_PDR, quatroIgual5_ocorrenciasPDR);
      CalcularOcorrencias_PDR(numeroLinhas, cincoPara1_PDR, cincoIgual1_ocorrenciasPDR);
      CalcularOcorrencias_PDR(numeroLinhas, maioriaTres_meioPara5_PDR, maioriaTres_meioIgual5_ocorrenciasPDR);
      CalcularOcorrencias_INV(numeroLinhas, quatroPara5_INV, quatroDif5_ocorrenciasINV);
      CalcularOcorrencias_INV(numeroLinhas, cincoPara1_INV, cincoDif1_ocorrenciasINV);
      CalcularOcorrencias_INV(numeroLinhas, maioriaTres_meioPara5_INV, maioriaTres_meioDif5_ocorrenciasINV);
     }
   else
      if(velasPor_quadrante == 6)
        {
         CalcularOcorrencias_PDR(numeroLinhas, quatroPara5_PDR, quatroIgual5_ocorrenciasPDR);
         CalcularOcorrencias_PDR(numeroLinhas, cincoPara6_PDR, cincoIgual6_ocorrenciasPDR);
         CalcularOcorrencias_PDR(numeroLinhas, seisPara1_PDR, seisIgual1_ocorrenciasPDR);
         CalcularOcorrencias_PDR(numeroLinhas, maioriaTres_meioPara5_PDR, maioriaTres_meioIgual5_ocorrenciasPDR);
         CalcularOcorrencias_PDR(numeroLinhas, maioriaTres_meioM5_altPara6_PDR, maioriaTres_meioM5_altIgual6_ocorrenciasPDR);
         CalcularOcorrencias_INV(numeroLinhas, quatroPara5_INV, quatroDif5_ocorrenciasINV);
         CalcularOcorrencias_INV(numeroLinhas, cincoPara6_INV, cincoDif6_ocorrenciasINV);
         CalcularOcorrencias_INV(numeroLinhas, seisPara1_INV, seisDif1_ocorrenciasINV);
         CalcularOcorrencias_INV(numeroLinhas, maioriaTres_meioPara5_INV, maioriaTres_meioDif5_ocorrenciasINV);
         CalcularOcorrencias_INV(numeroLinhas, maioriaTres_meioM5_altPara6_INV, maioriaTres_meioM5_altDif6_ocorrenciasINV);
        }
      else
         if(velasPor_quadrante == 4)
           {
            CalcularOcorrencias_PDR(numeroLinhas, quatroPara1_PDR, quatroIgual1_ocorrenciasPDR);
            CalcularOcorrencias_INV(numeroLinhas, quatroPara1_INV, quatroDif1_ocorrenciasINV);
           }

//+------------------------------------------------------------------+
//| CÁLCULO DE PORCENTAGENS DAS OCORRÊNCIAS (ESTATÍSTICAS)           |
//+------------------------------------------------------------------+
   umIgual2_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(umIgual2_ocorrenciasPDR[0][0], umIgual2_ocorrenciasPDR[0][1]);
   doisIgual3_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(doisIgual3_ocorrenciasPDR[0][0], doisIgual3_ocorrenciasPDR[0][1]);
   tresIgual4_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(tresIgual4_ocorrenciasPDR[0][0], tresIgual4_ocorrenciasPDR[0][1]);
   maioriaVelas_igual1Porcentagem_ocorrenciasPDR = CalcularPorcentagem_Ocorrencias(maioriaVelas_igual1Ocorrencias_PDR[0][0], maioriaVelas_igual1Ocorrencias_PDR[0][1]);
   maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(maioriaTres_primeirasIgual4_ocorrenciasPDR[0][0], maioriaTres_primeirasIgual4_ocorrenciasPDR[0][1]);
   maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(maioriaTres_ultimasIgual1_ocorrenciasPDR[0][0], maioriaTres_ultimasIgual1_ocorrenciasPDR[0][1]);
   umDif2_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(umDif2_ocorrenciasINV[0][0], umDif2_ocorrenciasINV[0][1]);
   doisDif3_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(doisDif3_ocorrenciasINV[0][0], doisDif3_ocorrenciasINV[0][1]);
   tresDif4_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(tresDif4_ocorrenciasINV[0][0], tresDif4_ocorrenciasINV[0][1]);
   maioriaVelas_dif1Porcentagem_ocorrenciasINV = CalcularPorcentagem_Ocorrencias(maioriaVelas_dif1Ocorrencias_INV[0][0], maioriaVelas_dif1Ocorrencias_INV[0][1]);
   maioriaTres_primeirasDif4_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(maioriaTres_primeirasDif4_ocorrenciasINV[0][0], maioriaTres_primeirasDif4_ocorrenciasINV[0][1]);
   maioriaTres_ultimasDif1_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(maioriaTres_ultimasDif1_ocorrenciasINV[0][0], maioriaTres_ultimasDif1_ocorrenciasINV[0][1]);

//--- Porcentagens Específicas Para Certos Timeframes
   if(velasPor_quadrante == 5)
     {
      quatroIgual5_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(quatroIgual5_ocorrenciasPDR[0][0], quatroIgual5_ocorrenciasPDR[0][1]);
      cincoIgual1_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(cincoIgual1_ocorrenciasPDR[0][0], cincoIgual1_ocorrenciasPDR[0][1]);
      maioriaTres_meioIgual5_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(maioriaTres_meioIgual5_ocorrenciasPDR[0][0], maioriaTres_meioIgual5_ocorrenciasPDR[0][1]);
      quatroDif5_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(quatroDif5_ocorrenciasINV[0][0], quatroDif5_ocorrenciasINV[0][1]);
      cincoDif1_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(cincoDif1_ocorrenciasINV[0][0], cincoDif1_ocorrenciasINV[0][1]);
      maioriaTres_meioDif5_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(maioriaTres_meioDif5_ocorrenciasINV[0][0], maioriaTres_meioDif5_ocorrenciasINV[0][1]);

      matrizPorcentagem_ocorrenciasM1[0] = umIgual2_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[1] = doisIgual3_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[2] = tresIgual4_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[3] = maioriaVelas_igual1Porcentagem_ocorrenciasPDR;
      matrizPorcentagem_ocorrenciasM1[4] = maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[5] = maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[6] = umDif2_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[7] = doisDif3_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[8] = tresDif4_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[9] = maioriaVelas_dif1Porcentagem_ocorrenciasINV;
      matrizPorcentagem_ocorrenciasM1[10] = maioriaTres_primeirasDif4_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[11] = maioriaTres_ultimasDif1_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[12] = quatroIgual5_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[13] = cincoIgual1_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[14] = maioriaTres_meioIgual5_porcentagemOcorrencias_PDR;
      matrizPorcentagem_ocorrenciasM1[15] = quatroDif5_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[16] = cincoDif1_porcentagemOcorrencias_INV;
      matrizPorcentagem_ocorrenciasM1[17] = maioriaTres_meioDif5_porcentagemOcorrencias_INV;

      if(metodoLimite_barreira == 01)
        {
         limitePorcentagem_ocorrencias = NormalizeDouble((umIgual2_porcentagemOcorrencias_PDR +
                                         doisIgual3_porcentagemOcorrencias_PDR +
                                         tresIgual4_porcentagemOcorrencias_PDR +
                                         maioriaVelas_igual1Porcentagem_ocorrenciasPDR +
                                         maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR +
                                         maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR +
                                         umDif2_porcentagemOcorrencias_INV +
                                         doisDif3_porcentagemOcorrencias_INV +
                                         tresDif4_porcentagemOcorrencias_INV +
                                         maioriaVelas_dif1Porcentagem_ocorrenciasINV +
                                         maioriaTres_primeirasDif4_porcentagemOcorrencias_INV +
                                         maioriaTres_ultimasDif1_porcentagemOcorrencias_INV +
                                         quatroIgual5_porcentagemOcorrencias_PDR +
                                         cincoIgual1_porcentagemOcorrencias_PDR +
                                         maioriaTres_meioIgual5_porcentagemOcorrencias_PDR +
                                         quatroDif5_porcentagemOcorrencias_INV +
                                         cincoDif1_porcentagemOcorrencias_INV +
                                         maioriaTres_meioDif5_porcentagemOcorrencias_INV)/
                                         18, 2);
        }
      else
         if(metodoLimite_barreira == 02)
           {
            indiceMaior_porcentagemOcorrencias = ArrayMaximum(matrizPorcentagem_ocorrenciasM1, 0, WHOLE_ARRAY);
            limitePorcentagem_ocorrencias = indiceMaior_porcentagemOcorrencias;
           }
         else
            if(metodoLimite_barreira == 03)
              {
               limitePorcentagem_ocorrencias = limiteBarreira;
              }
     }
//--- APLICAR MESMAS CONDIÇÕES EM M5 E M15

   else
      if(velasPor_quadrante == 6)
        {
         quatroIgual5_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(quatroIgual5_ocorrenciasPDR[0][0], quatroIgual5_ocorrenciasPDR[0][1]);
         cincoIgual6_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(cincoIgual6_ocorrenciasPDR[0][0], cincoIgual6_ocorrenciasPDR[0][1]);
         seisIgual1_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(seisIgual1_ocorrenciasPDR[0][0], seisIgual1_ocorrenciasPDR[0][1]);
         maioriaTres_meioIgual5_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(maioriaTres_meioIgual5_ocorrenciasPDR[0][0], maioriaTres_meioIgual5_ocorrenciasPDR[0][1]);
         maioriaTres_meioM5_altIgual6_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(maioriaTres_meioM5_altIgual6_ocorrenciasPDR[0][0], maioriaTres_meioM5_altIgual6_ocorrenciasPDR[0][1]);
         quatroDif5_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(quatroDif5_ocorrenciasINV[0][0], quatroDif5_ocorrenciasINV[0][1]);
         cincoDif6_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(cincoDif6_ocorrenciasINV[0][0], cincoDif6_ocorrenciasINV[0][1]);
         seisDif1_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(seisDif1_ocorrenciasINV[0][0], seisDif1_ocorrenciasINV[0][1]);
         maioriaTres_meioDif5_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(maioriaTres_meioDif5_ocorrenciasINV[0][0], maioriaTres_meioDif5_ocorrenciasINV[0][1]);
         maioriaTres_meioM5_altDif6_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(maioriaTres_meioM5_altDif6_ocorrenciasINV[0][0], maioriaTres_meioM5_altDif6_ocorrenciasINV[0][1]);

         limitePorcentagem_ocorrencias = NormalizeDouble((umIgual2_porcentagemOcorrencias_PDR +
                                         doisIgual3_porcentagemOcorrencias_PDR +
                                         tresIgual4_porcentagemOcorrencias_PDR +
                                         maioriaVelas_igual1Porcentagem_ocorrenciasPDR +
                                         maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR +
                                         maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR +
                                         umDif2_porcentagemOcorrencias_INV +
                                         doisDif3_porcentagemOcorrencias_INV +
                                         tresDif4_porcentagemOcorrencias_INV +
                                         maioriaVelas_dif1Porcentagem_ocorrenciasINV +
                                         maioriaTres_primeirasDif4_porcentagemOcorrencias_INV +
                                         maioriaTres_ultimasDif1_porcentagemOcorrencias_INV +
                                         quatroIgual5_porcentagemOcorrencias_PDR +
                                         cincoIgual6_porcentagemOcorrencias_PDR +
                                         seisIgual1_porcentagemOcorrencias_PDR +
                                         maioriaTres_meioIgual5_porcentagemOcorrencias_PDR +
                                         maioriaTres_meioM5_altIgual6_porcentagemOcorrencias_PDR +
                                         quatroDif5_porcentagemOcorrencias_INV +
                                         cincoDif6_porcentagemOcorrencias_INV +
                                         seisDif1_porcentagemOcorrencias_INV +
                                         maioriaTres_meioDif5_porcentagemOcorrencias_INV +
                                         maioriaTres_meioM5_altDif6_porcentagemOcorrencias_INV) /
                                         22, 2);
        }
      else
         if(velasPor_quadrante == 4)
           {
            quatroIgual1_porcentagemOcorrencias_PDR = CalcularPorcentagem_Ocorrencias(quatroIgual1_ocorrenciasPDR[0][0], quatroIgual1_ocorrenciasPDR[0][1]);
            quatroDif1_porcentagemOcorrencias_INV = CalcularPorcentagem_Ocorrencias(quatroDif1_ocorrenciasINV[0][0], quatroDif1_ocorrenciasINV[0][1]);

            limitePorcentagem_ocorrencias = NormalizeDouble((umIgual2_porcentagemOcorrencias_PDR +
                                            doisIgual3_porcentagemOcorrencias_PDR +
                                            tresIgual4_porcentagemOcorrencias_PDR +
                                            maioriaVelas_igual1Porcentagem_ocorrenciasPDR +
                                            maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR +
                                            maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR +
                                            umDif2_porcentagemOcorrencias_INV +
                                            doisDif3_porcentagemOcorrencias_INV +
                                            tresDif4_porcentagemOcorrencias_INV +
                                            maioriaVelas_dif1Porcentagem_ocorrenciasINV +
                                            maioriaTres_primeirasDif4_porcentagemOcorrencias_INV +
                                            maioriaTres_ultimasDif1_porcentagemOcorrencias_INV +
                                            quatroIgual1_porcentagemOcorrencias_PDR +
                                            quatroDif1_porcentagemOcorrencias_INV) /
                                            14, 2);
           }

//+------------------------------------------------------------------+
//| ORGANIZAÇÃO E RANKING DAS ESTRATÉGIAS                            |
//+------------------------------------------------------------------+
   PrepararMatriz_DoubleDois(26, porcentagemOcorrencias_organizada);
   PrepararVetor_Double(26, porcentagemOcorrencias_vetor);
   PrepararVetor_Double(26, porcentagemOcorrencias_titulo);

   for(int i = 0; i < ArrayRange(porcentagemOcorrencias_organizada, 0); i++)
     {
      porcentagemOcorrencias_organizada[i]
      [1] = i;
     }

   porcentagemOcorrencias_organizada[0][0] = umIgual2_porcentagemOcorrencias_PDR;
   porcentagemOcorrencias_organizada[1][0] = umDif2_porcentagemOcorrencias_INV;
   porcentagemOcorrencias_organizada[2][0] = doisIgual3_porcentagemOcorrencias_PDR;
   porcentagemOcorrencias_organizada[3][0] = doisDif3_porcentagemOcorrencias_INV;
   porcentagemOcorrencias_organizada[4][0] = tresIgual4_porcentagemOcorrencias_PDR;
   porcentagemOcorrencias_organizada[5][0] = tresDif4_porcentagemOcorrencias_INV;

   if(velasPor_quadrante == 4)
     {
      porcentagemOcorrencias_organizada[6]
      [0] = quatroIgual1_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[7][0] = quatroDif1_porcentagemOcorrencias_INV;
     }
   else
     {
      porcentagemOcorrencias_organizada[6][0] = 0;
      porcentagemOcorrencias_organizada[7][0] = 0;
     }

   if(velasPor_quadrante == 5 || velasPor_quadrante == 6)
     {
      porcentagemOcorrencias_organizada[8]
      [0] = quatroIgual5_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[9][0] = quatroDif5_porcentagemOcorrencias_INV;
      porcentagemOcorrencias_organizada[20][0] = maioriaTres_meioIgual5_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[21][0] = maioriaTres_meioDif5_porcentagemOcorrencias_INV;
     }
   else
     {
      porcentagemOcorrencias_organizada[8][0] = 0;
      porcentagemOcorrencias_organizada[9][0] = 0;
      porcentagemOcorrencias_organizada[20][0] = 0;
      porcentagemOcorrencias_organizada[21][0] = 0;
     }

   if(velasPor_quadrante == 5)
     {
      porcentagemOcorrencias_organizada[10]
      [0] = cincoIgual1_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[11][0] = cincoDif1_porcentagemOcorrencias_INV;
     }
   else
     {
      porcentagemOcorrencias_organizada[10][0] = 0;
      porcentagemOcorrencias_organizada[11][0] = 0;
     }

   if(velasPor_quadrante == 6)
     {
      porcentagemOcorrencias_organizada[12]
      [0] = cincoIgual6_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[13][0] = cincoDif6_porcentagemOcorrencias_INV;
      porcentagemOcorrencias_organizada[14][0] = seisIgual1_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[15][0] = seisDif1_porcentagemOcorrencias_INV;
      porcentagemOcorrencias_organizada[22][0] = maioriaTres_meioM5_altIgual6_porcentagemOcorrencias_PDR;
      porcentagemOcorrencias_organizada[23][0] = maioriaTres_meioM5_altDif6_porcentagemOcorrencias_INV;
     }
   else
     {
      porcentagemOcorrencias_organizada[12][0] = 0;
      porcentagemOcorrencias_organizada[13][0] = 0;
      porcentagemOcorrencias_organizada[14][0] = 0;
      porcentagemOcorrencias_organizada[15][0] = 0;
      porcentagemOcorrencias_organizada[22][0] = 0;
      porcentagemOcorrencias_organizada[23][0] = 0;
     }

   porcentagemOcorrencias_organizada[16][0] = maioriaVelas_igual1Porcentagem_ocorrenciasPDR;
   porcentagemOcorrencias_organizada[17][0] = maioriaVelas_dif1Porcentagem_ocorrenciasINV;
   porcentagemOcorrencias_organizada[18][0] = maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR;
   porcentagemOcorrencias_organizada[19][0] = maioriaTres_primeirasDif4_porcentagemOcorrencias_INV;
   porcentagemOcorrencias_organizada[24][0] = maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR;
   porcentagemOcorrencias_organizada[25][0] = maioriaTres_ultimasDif1_porcentagemOcorrencias_INV;

//--- Organização e Reversão da Matriz Para Vetores Individuais
   ArraySort(porcentagemOcorrencias_organizada);
   ReverterMatriz_DoubleColuna1(porcentagemOcorrencias_vetor, porcentagemOcorrencias_organizada);
   ReverterMatriz_DoubleColuna2(porcentagemOcorrencias_titulo, porcentagemOcorrencias_organizada);

////+------------------------------------------------------------------+
////| SINAL DE ENTRADA PARA AS ESTRATÉGIAS                             |
////+------------------------------------------------------------------+
   katanaLoss_concatenado = ConcatenarLoss_Katana(katanaBarreira);

   umIgual2_sinalKatana_PDR = DetectarSinal_KatanaPDR(umPara2_PDRHorario_negociacao, katanaBarreira, umIgual2_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
   doisIgual3_sinalKatana_PDR = DetectarSinal_KatanaPDR(doisPara3_PDRHorario_negociacao, katanaBarreira, doisIgual3_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
   tresIgual4_sinalKatana_PDR = DetectarSinal_KatanaPDR(tresPara4_PDRHorario_negociacao, katanaBarreira, tresIgual4_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
   maioriaVelas_igual1Sinal_katanaPDR = DetectarSinal_KatanaPDR(maioriaVelas_para1PDR_horarioNegociacao, katanaBarreira, maioriaVelas_igual1Porcentagem_ocorrenciasPDR,  porcentagemBarreira, limitePorcentagem_ocorrencias);
   maioriaTres_primeirasIgual4_sinalKatana_PDR = DetectarSinal_KatanaPDR(maioriaTres_primeirasPara4_PDRHorario_negociacao, katanaBarreira, maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
   maioriaTres_ultimasIgual1_sinalKatana_PDR = DetectarSinal_KatanaPDR(maioriaTres_ultimasPara1_PDRHorario_negociacao, katanaBarreira, maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
   umDif2_sinalKatana_INV = DetectarSinal_KatanaINV(umPara2_INVHorario_negociacao, katanaBarreira, umDif2_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
   doisDif3_sinalKatana_INV = DetectarSinal_KatanaINV(doisPara3_INVHorario_negociacao, katanaBarreira, doisDif3_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
   tresDif4_sinalKatana_INV = DetectarSinal_KatanaINV(tresPara4_INVHorario_negociacao, katanaBarreira, tresDif4_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
   maioriaVelas_dif1Sinal_katanaINV = DetectarSinal_KatanaINV(maioriaVelas_para1INV_horarioNegociacao, katanaBarreira, maioriaVelas_dif1Porcentagem_ocorrenciasINV, porcentagemBarreira, limitePorcentagem_ocorrencias);
   maioriaTres_primeirasDif4_sinalKatana_INV = DetectarSinal_KatanaINV(maioriaTres_primeirasPara4_INVHorario_negociacao, katanaBarreira, maioriaTres_primeirasDif4_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
   maioriaTres_ultimasDif1_sinalKatana_INV = DetectarSinal_KatanaINV(maioriaTres_ultimasPara1_INVHorario_negociacao, katanaBarreira, maioriaTres_ultimasDif1_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);

   if(velasPor_quadrante == 5)
     {
      quatroIgual5_sinalKatana_PDR = DetectarSinal_KatanaPDR(quatroPara5_PDRHorario_negociacao, katanaBarreira, quatroIgual5_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
      cincoIgual1_sinalKatana_PDR = DetectarSinal_KatanaPDR(cincoPara1_PDRHorario_negociacao, katanaBarreira, cincoIgual1_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
      maioriaTres_meioIgual5_sinalKatana_PDR = DetectarSinal_KatanaPDR(maioriaTres_meioPara5_PDRHorario_negociacao, katanaBarreira, maioriaTres_meioIgual5_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
      quatroDif5_sinalKatana_INV = DetectarSinal_KatanaINV(quatroPara5_INVHorario_negociacao, katanaBarreira, quatroDif5_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
      cincoDif1_sinalKatana_INV = DetectarSinal_KatanaINV(cincoPara1_INVHorario_negociacao, katanaBarreira, cincoDif1_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
      maioriaTres_meioDif5_sinalKatana_INV = DetectarSinal_KatanaINV(maioriaTres_meioPara5_INVHorario_negociacao, katanaBarreira, maioriaTres_meioDif5_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
     }
   else
      if(velasPor_quadrante == 6)
        {
         quatroIgual5_sinalKatana_PDR = DetectarSinal_KatanaPDR(quatroPara5_PDRHorario_negociacao, katanaBarreira, quatroIgual5_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
         cincoIgual6_sinalKatana_PDR = DetectarSinal_KatanaPDR(cincoPara6_PDRHorario_negociacao, katanaBarreira, cincoIgual6_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
         seisIgual1_sinalKatana_PDR = DetectarSinal_KatanaPDR(seisPara1_PDRHorario_negociacao, katanaBarreira, seisIgual1_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
         maioriaTres_meioIgual5_sinalKatana_PDR = DetectarSinal_KatanaPDR(maioriaTres_meioPara5_PDRHorario_negociacao, katanaBarreira, maioriaTres_meioIgual5_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
         maioriaTres_meioM5_altIgual6_sinalKatana_PDR = DetectarSinal_KatanaPDR(maioriaTres_meioM5_altPara6_PDRHorario_negociacao, katanaBarreira, maioriaTres_meioM5_altIgual6_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
         quatroDif5_sinalKatana_INV = DetectarSinal_KatanaINV(quatroPara5_INVHorario_negociacao, katanaBarreira, quatroDif5_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
         cincoDif6_sinalKatana_INV = DetectarSinal_KatanaINV(cincoPara6_INVHorario_negociacao, katanaBarreira, cincoDif6_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
         seisDif1_sinalKatana_INV = DetectarSinal_KatanaINV(seisPara1_INVHorario_negociacao, katanaBarreira, seisDif1_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
         maioriaTres_meioDif5_sinalKatana_INV = DetectarSinal_KatanaINV(maioriaTres_meioPara5_INVHorario_negociacao, katanaBarreira, maioriaTres_meioDif5_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
         maioriaTres_meioM5_altDif6_sinalKatana_INV = DetectarSinal_KatanaINV(maioriaTres_meioM5_altPara6_INVHorario_negociacao, katanaBarreira, maioriaTres_meioM5_altDif6_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
        }
      else
         if(velasPor_quadrante == 4)
           {
            quatroIgual1_sinalKatana_PDR = DetectarSinal_KatanaPDR(quatroPara1_PDRHorario_negociacao, katanaBarreira, quatroIgual1_porcentagemOcorrencias_PDR, porcentagemBarreira, limitePorcentagem_ocorrencias);
            quatroDif1_sinalKatana_INV = DetectarSinal_KatanaINV(quatroPara1_INVHorario_negociacao, katanaBarreira, quatroDif1_porcentagemOcorrencias_INV, porcentagemBarreira, limitePorcentagem_ocorrencias);
           }

//+------------------------------------------------------------------+
//| PREPARAÇÃO DAS TABELAS DE ESTATÍSTICAS                           |
//+------------------------------------------------------------------+
   if(velasPor_quadrante == 5)
     {
      PrepararMatriz_StringQuatro(18, tabelaFinal_ocorrencias);
      PrepararMatriz_StringTres(18, tabelaFinal_assertividade);
      PrepararMatriz_StringQuatro(18, tabelaEntrada);
     }
   else
      if(velasPor_quadrante == 6)
        {
         PrepararMatriz_StringQuatro(22, tabelaFinal_ocorrencias);
         PrepararMatriz_StringTres(22, tabelaFinal_assertividade);
         PrepararMatriz_StringQuatro(22, tabelaEntrada);
        }
      else
         if(velasPor_quadrante == 4)
           {
            PrepararMatriz_StringQuatro(14, tabelaFinal_ocorrencias);
            PrepararMatriz_StringTres(14, tabelaFinal_assertividade);
            PrepararMatriz_StringQuatro(14, tabelaEntrada);
           }

//+------------------------------------------------------------------+
//| TABELA DE OCORRÊNCIAS                                            |
//+------------------------------------------------------------------+
   for(int i = 0; i < ArrayRange(tabelaFinal_ocorrencias, 0); i++)
     {
      tabelaFinal_ocorrencias[i][0] = StringFormat("%02i", i+1) + "º";
      tabelaFinal_ocorrencias[i][2] = DoubleToString(porcentagemOcorrencias_vetor[i],2) + "%";

      switch((int)porcentagemOcorrencias_titulo[i])
        {
         case 0:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "1 = 2 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "1 = 2/3 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "1 = 2/3/4 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", umIgual2_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", umIgual2_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = umIgual2_sinalKatana_PDR;
            break;
         case 1:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "1 <> 2 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "1 <> 2/3 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "1 <> 2/3/4 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", umDif2_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", umDif2_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = umDif2_sinalKatana_INV;
            break;
         case 2:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "2 = 3 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "2 = 3/4 (PDR)";
                 }
               else
                  if(posicoes == 3 && velasPor_quadrante != 4)
                    {
                     tabelaFinal_ocorrencias[i][1] = "2 = 3/4/5 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_ocorrencias[i][1] = "2 = 3/4/1 (PDR)";
                       }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", doisIgual3_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", doisIgual3_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = doisIgual3_sinalKatana_PDR;
            break;
         case 3:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "2 <> 3 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "2 <> 3/4 (INV)";
                 }
               else
                  if(posicoes == 3 && velasPor_quadrante != 4)
                    {
                     tabelaFinal_ocorrencias[i][1] = "2 <> 3/4/5 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_ocorrencias[i][1] = "2 <> 3/4/1 (INV)";
                       }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", doisDif3_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", doisDif3_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = doisDif3_sinalKatana_INV;
            break;
         case 4:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "3 = 4 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_ocorrencias[i][1] = "3 = 4/5 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_ocorrencias[i][1] = "3 = 4/1 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_ocorrencias[i][1] = "3 = 4/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_ocorrencias[i][1] = "3 = 4/5/1 (PDR)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_ocorrencias[i][1] = "3 = 4/5/6 (PDR)";
                             }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", tresIgual4_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", tresIgual4_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = tresIgual4_sinalKatana_PDR;
            break;
         case 5:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "3 <> 4 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_ocorrencias[i][1] = "3 <> 4/5 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_ocorrencias[i][1] = "3 <> 4/1 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_ocorrencias[i][1] = "3 <> 4/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_ocorrencias[i][1] = "3 <> 4/5/1 (INV)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_ocorrencias[i][1] = "3 <> 4/5/6 (INV)";
                             }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", tresDif4_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", tresDif4_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = tresDif4_sinalKatana_INV;
            break;
         case 6:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "4 = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "4 = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "4 = 1/2/3 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", quatroIgual1_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", quatroIgual1_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = quatroIgual1_sinalKatana_PDR;
            break;
         case 7:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "4 <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "4 <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "4 <> 1/2/3 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", quatroDif1_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", quatroDif1_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = quatroDif1_sinalKatana_INV;
            break;
         case 8:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "4 = 5 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_ocorrencias[i][1] = "4 = 5/1 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_ocorrencias[i][1] = "4 = 5/6 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_ocorrencias[i][1] = "4 = 5/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_ocorrencias[i][1] = "4 = 5/6/1 (PDR)";
                          }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", quatroIgual5_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", quatroIgual5_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = quatroIgual5_sinalKatana_PDR;
            break;
         case 9:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "4 <> 5 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_ocorrencias[i][1] = "4 <> 5/1 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_ocorrencias[i][1] = "4 <> 5/6 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_ocorrencias[i][1] = "4 <> 5/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_ocorrencias[i][1] = "4 <> 5/6/1 (INV)";
                          }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", quatroDif5_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", quatroDif5_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = quatroDif5_sinalKatana_INV;
            break;
         case 10:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "5 = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "5 = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "5 = 1/2/3 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", cincoIgual1_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", cincoIgual1_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = cincoIgual1_sinalKatana_PDR;
            break;
         case 11:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "5 <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "5 <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "5 <> 1/2/3 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", cincoDif1_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", cincoDif1_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = cincoDif1_sinalKatana_INV;
            break;
         case 12:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "5 = 6 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "5 = 6/1 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "5 = 6/1/2 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", cincoIgual6_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", cincoIgual6_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = cincoIgual6_sinalKatana_PDR;
            break;
         case 13:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "5 <> 6 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "5 <> 6/1 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "5 <> 6/1/2 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", cincoDif6_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", cincoDif6_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = cincoDif6_sinalKatana_INV;
            break;
         case 14:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "6 = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "6 = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "6 = 1/2/3 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", seisIgual1_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", seisIgual1_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = seisIgual1_sinalKatana_PDR;
            break;
         case 15:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "6 <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "6 <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "6 <> 1/2/3 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", seisDif1_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", seisDif1_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = seisDif1_sinalKatana_INV;
            break;
         case 16:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (Quadrante) = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (Quadrante) = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (Quadrante) = 1/2/3 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaVelas_igual1Ocorrencias_PDR[0][0]) + "/" + StringFormat("%02.0f", maioriaVelas_igual1Ocorrencias_PDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaVelas_igual1Sinal_katanaPDR;
            break;
         case 17:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (Quadrante) <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (Quadrante) <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (Quadrante) <> 1/2/3 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaVelas_dif1Ocorrencias_INV[0][0]) + "/" + StringFormat("%02.0f", maioriaVelas_dif1Ocorrencias_INV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaVelas_dif1Sinal_katanaINV;
            break;
         case 18:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) = 4 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) = 4/5 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) = 4/1 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) = 4/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) = 4/5/1 (PDR)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) = 4/5/6 (PDR)";
                             }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_primeirasIgual4_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_primeirasIgual4_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_primeirasIgual4_sinalKatana_PDR;
            break;
         case 19:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) <> 4 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) <> 4/5 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) <> 4/1 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) <> 4/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) <> 4/5/1 (INV)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_ocorrencias[i][1] = "Maioria (3 Primeiras) <> 4/5/6 (INV)";
                             }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_primeirasDif4_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_primeirasDif4_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_primeirasDif4_sinalKatana_INV;
            break;
         case 20:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) = 5 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) = 5/1 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) = 5/6 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) = 5/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) = 5/6/1 (PDR)";
                          }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_meioIgual5_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_meioIgual5_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_meioIgual5_sinalKatana_PDR;
            break;
         case 21:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) <> 5 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) <> 5/1 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) <> 5/6 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) <> 5/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio) <> 5/6/1 (INV)";
                          }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_meioDif5_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_meioDif5_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_meioDif5_sinalKatana_INV;
            break;
         case 22:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio M5 Alt) = 6 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio M5 Alt) = 6/1 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio M5 Alt) = 6/1/2 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_meioM5_altIgual6_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_meioM5_altIgual6_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_meioM5_altIgual6_sinalKatana_PDR;
            break;
         case 23:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio M5 Alt) <> 6 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio M5 Alt) <> 6/1 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Meio M5 Alt) <> 6/1/2 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_meioM5_altDif6_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_meioM5_altDif6_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_meioM5_altDif6_sinalKatana_INV;
            break;
         case 24:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Últimas) = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Últimas) = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Últimas) = 1/2/3 (PDR)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_ultimasIgual1_ocorrenciasPDR[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_ultimasIgual1_ocorrenciasPDR[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_ultimasIgual1_sinalKatana_PDR;
            break;
         case 25:
            if(posicoes == 1)
              {
               tabelaFinal_ocorrencias[i][1] = "Maioria (3 Últimas) <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_ocorrencias[i][1] = "Maioria (3 Últimas) <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_ocorrencias[i][1] = "Maioria (3 Últimas) <> 1/2/3 (INV)";
                    }
            tabelaFinal_ocorrencias[i][2] = StringFormat("%02.0f", maioriaTres_ultimasDif1_ocorrenciasINV[0][0]) + "/" + StringFormat("%02.0f", maioriaTres_ultimasDif1_ocorrenciasINV[0][1]) + " (" + tabelaFinal_ocorrencias[i][2] + ")";
            tabelaFinal_ocorrencias[i][3] = maioriaTres_ultimasDif1_sinalKatana_INV;
            break;
        }
     }

//+------------------------------------------------------------------+
//| TABELA DE ENTRADA                                                |
//+------------------------------------------------------------------+
   for(int i = 0; i < ArrayRange(tabelaEntrada, 0); i++)
     {
      if(tabelaFinal_ocorrencias[i][3] == "KATANÁ!")
        {
         tabelaEntrada[i][0] = tabelaFinal_ocorrencias[i][0] + " LUGAR (OCORRÊNCIAS)";

         tabelaEntrada[i][1] = tabelaFinal_ocorrencias[i][1];

         tabelaEntrada[i][2] = tabelaFinal_ocorrencias[i][2];

         tabelaEntrada[i][3] = tabelaFinal_ocorrencias[i][3];
        }
      else
        {
         tabelaEntrada[i][0] = "-";

         tabelaEntrada[i][1] = "-";

         tabelaEntrada[i][2] = "-";

         tabelaEntrada[i][3] = "AGUARDE";
        }
     }

   PrepararVetor_Double(ArrayRange(tabelaEntrada, 0), ordenacaoEntrada);
   for(int i = 0; i < ArrayRange(tabelaEntrada, 0); i++)
     {
      if(tabelaEntrada[i][2] == "-")
        {
         ordenacaoEntrada[i] = 0.0;
        }
      else
        {
         ordenacaoEntrada[i] = StringToDouble(tabelaEntrada[i][2]);
        }
     }
   indiceEntrada = ArrayMaximum(ordenacaoEntrada, 0, WHOLE_ARRAY);


//+------------------------------------------------------------------+
//| CÁLCULO DE ASSERTIVIDADE DAS ESTRATÉGIAS                         |
//+------------------------------------------------------------------+
   umIgual2_assertividadeKatana_PDR = CalcularAssertividade_PDR(umPara2_PDRHorario_negociacao, katanaBarreira, umIgual2_quantidadeVitoria_katanaPDR, umIgual2_quantidadeDerrota_katanaPDR, porcentagemBarreira, umIgual2_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, umIgual2_entradasPDR, "      1 = 2");
   doisIgual3_assertividadeKatana_PDR = CalcularAssertividade_PDR(doisPara3_PDRHorario_negociacao, katanaBarreira, doisIgual3_quantidadeVitoria_katanaPDR, doisIgual3_quantidadeDerrota_katanaPDR, porcentagemBarreira, doisIgual3_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, doisIgual3_entradasPDR, "      2 = 3");
   tresIgual4_assertividadeKatana_PDR = CalcularAssertividade_PDR(tresPara4_PDRHorario_negociacao, katanaBarreira, tresIgual4_quantidadeVitoria_katanaPDR, tresIgual4_quantidadeDerrota_katanaPDR, porcentagemBarreira, tresIgual4_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, tresIgual4_entradasPDR, "      3 = 4");
   maioriaVelas_igual1Assertividade_katanaPDR = CalcularAssertividade_PDR(maioriaVelas_para1PDR_horarioNegociacao, katanaBarreira, maioriaVelas_igual1Quantidade_vitoriaKatana_PDR, maioriaVelas_igual1Quantidade_derrotaKatana_PDR, porcentagemBarreira, maioriaVelas_igual1Porcentagem_ocorrenciasPDR, limitePorcentagem_ocorrencias, maioriaVelas_igual1Entradas_PDR, "    MQ = 1");
   maioriaTres_primeirasIgual4_assertividadeKatana_PDR = CalcularAssertividade_PDR(maioriaTres_primeirasPara4_PDRHorario_negociacao, katanaBarreira, maioriaTres_primeirasIgual4_quantidadeVitoria_katanaPDR, maioriaTres_primeirasIgual4_quantidadeDerrota_katanaPDR, porcentagemBarreira, maioriaTres_primeirasIgual4_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, maioriaTres_primeirasIgual4_entradasPDR, "   M3P = 4");
   maioriaTres_ultimasIgual1_assertividadeKatana_PDR = CalcularAssertividade_PDR(maioriaTres_ultimasPara1_PDRHorario_negociacao, katanaBarreira, maioriaTres_ultimasIgual1_quantidadeVitoria_katanaPDR, maioriaTres_ultimasIgual1_quantidadeDerrota_katanaPDR, porcentagemBarreira, maioriaTres_ultimasIgual1_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, maioriaTres_ultimasIgual1_entradasPDR, "   M3U = 1");
   umDif2_assertividadeKatana_INV = CalcularAssertividade_INV(umPara2_INVHorario_negociacao, katanaBarreira, umDif2_quantidadeVitoria_katanaINV, umDif2_quantidadeDerrota_katanaINV, porcentagemBarreira, umDif2_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, umDif2_entradasINV, "     1 <> 2");
   doisDif3_assertividadeKatana_INV = CalcularAssertividade_INV(doisPara3_INVHorario_negociacao, katanaBarreira, doisDif3_quantidadeVitoria_katanaINV, doisDif3_quantidadeDerrota_katanaINV, porcentagemBarreira, doisDif3_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, doisDif3_entradasINV, "     2 <> 3");
   tresDif4_assertividadeKatana_INV = CalcularAssertividade_INV(tresPara4_INVHorario_negociacao, katanaBarreira, tresDif4_quantidadeVitoria_katanaINV, tresDif4_quantidadeDerrota_katanaINV, porcentagemBarreira, tresDif4_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, tresDif4_entradasINV, "     3 <> 4");
   maioriaVelas_dif1Assertividade_katanaINV = CalcularAssertividade_INV(maioriaVelas_para1INV_horarioNegociacao, katanaBarreira, maioriaVelas_dif1Quantidade_vitoriaKatana_INV, maioriaVelas_dif1Quantidade_derrotaKatana_INV, porcentagemBarreira, maioriaVelas_dif1Porcentagem_ocorrenciasINV, limitePorcentagem_ocorrencias, maioriaVelas_dif1Entradas_INV, "   MQ <> 1");
   maioriaTres_primeirasDif4_assertividadeKatana_INV = CalcularAssertividade_INV(maioriaTres_primeirasPara4_INVHorario_negociacao, katanaBarreira, maioriaTres_primeirasDif4_quantidadeVitoria_katanaINV, maioriaTres_primeirasDif4_quantidadeDerrota_katanaINV, porcentagemBarreira, maioriaTres_primeirasDif4_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, maioriaTres_primeirasDif4_entradasINV, "  M3P <> 4");
   maioriaTres_ultimasDif1_assertividadeKatana_INV = CalcularAssertividade_INV(maioriaTres_ultimasPara1_INVHorario_negociacao, katanaBarreira, maioriaTres_ultimasDif1_quantidadeVitoria_katanaINV, maioriaTres_ultimasDif1_quantidadeDerrota_katanaINV, porcentagemBarreira, maioriaTres_ultimasDif1_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, maioriaTres_ultimasDif1_entradasINV, "  M3U <> 1");

   if(velasPor_quadrante == 5)
     {
      quatroIgual5_assertividadeKatana_PDR = CalcularAssertividade_PDR(quatroPara5_PDRHorario_negociacao, katanaBarreira, quatroIgual5_quantidadeVitoria_katanaPDR, quatroIgual5_quantidadeDerrota_katanaPDR, porcentagemBarreira, quatroIgual5_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, quatroIgual5_entradasPDR, "      4 = 5");
      cincoIgual1_assertividadeKatana_PDR = CalcularAssertividade_PDR(cincoPara1_PDRHorario_negociacao, katanaBarreira, cincoIgual1_quantidadeVitoria_katanaPDR, cincoIgual1_quantidadeDerrota_katanaPDR, porcentagemBarreira, cincoIgual1_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, cincoIgual1_entradasPDR, "      5 = 1");
      maioriaTres_meioIgual5_assertividadeKatana_PDR = CalcularAssertividade_PDR(maioriaTres_meioPara5_PDRHorario_negociacao, katanaBarreira, maioriaTres_meioIgual5_quantidadeVitoria_katanaPDR, maioriaTres_meioIgual5_quantidadeDerrota_katanaPDR, porcentagemBarreira, maioriaTres_meioIgual5_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, maioriaTres_meioIgual5_entradasPDR, "   M3M = 5");
      quatroDif5_assertividadeKatana_INV = CalcularAssertividade_INV(quatroPara5_INVHorario_negociacao, katanaBarreira, quatroDif5_quantidadeVitoria_katanaINV, quatroDif5_quantidadeDerrota_katanaINV, porcentagemBarreira, quatroDif5_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, quatroDif5_entradasINV, "     4 <> 5");
      cincoDif1_assertividadeKatana_INV = CalcularAssertividade_INV(cincoPara1_INVHorario_negociacao, katanaBarreira, cincoDif1_quantidadeVitoria_katanaINV, cincoDif1_quantidadeDerrota_katanaINV, porcentagemBarreira, cincoDif1_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, cincoDif1_entradasINV, "     5 <> 1");
      maioriaTres_meioDif5_assertividadeKatana_INV = CalcularAssertividade_INV(maioriaTres_meioPara5_INVHorario_negociacao, katanaBarreira, maioriaTres_meioDif5_quantidadeVitoria_katanaINV, maioriaTres_meioDif5_quantidadeDerrota_katanaINV, porcentagemBarreira, maioriaTres_meioDif5_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, maioriaTres_meioDif5_entradasINV, "  M3M <> 5");
     }
   else
      if(velasPor_quadrante == 6)
        {
         quatroIgual5_assertividadeKatana_PDR = CalcularAssertividade_PDR(quatroPara5_PDRHorario_negociacao, katanaBarreira, quatroIgual5_quantidadeVitoria_katanaPDR, quatroIgual5_quantidadeDerrota_katanaPDR, porcentagemBarreira, quatroIgual5_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, quatroIgual5_entradasPDR, "      4 = 5");
         cincoIgual6_assertividadeKatana_PDR = CalcularAssertividade_PDR(cincoPara6_PDRHorario_negociacao, katanaBarreira, cincoIgual6_quantidadeVitoria_katanaPDR, cincoIgual6_quantidadeDerrota_katanaPDR, porcentagemBarreira, cincoIgual6_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, cincoIgual6_entradasPDR, "      5 = 6");
         seisIgual1_assertividadeKatana_PDR = CalcularAssertividade_PDR(seisPara1_PDRHorario_negociacao, katanaBarreira, seisIgual1_quantidadeVitoria_katanaPDR, seisIgual1_quantidadeDerrota_katanaPDR, porcentagemBarreira, seisIgual1_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, seisIgual1_entradasPDR, "      6 = 1");
         maioriaTres_meioIgual5_assertividadeKatana_PDR = CalcularAssertividade_PDR(maioriaTres_meioPara5_PDRHorario_negociacao, katanaBarreira, maioriaTres_meioIgual5_quantidadeVitoria_katanaPDR, maioriaTres_meioIgual5_quantidadeDerrota_katanaPDR, porcentagemBarreira, maioriaTres_meioIgual5_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, maioriaTres_meioIgual5_entradasPDR, "   M3M = 5");
         maioriaTres_meioM5_altIgual6_assertividadeKatana_PDR = CalcularAssertividade_PDR(maioriaTres_meioM5_altPara6_PDRHorario_negociacao, katanaBarreira, maioriaTres_meioM5_altIgual6_quantidadeVitoria_katanaPDR, maioriaTres_meioM5_altIgual6_quantidadeDerrota_katanaPDR, porcentagemBarreira, maioriaTres_meioM5_altIgual6_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, maioriaTres_meioM5_altIgual6_entradasPDR, " M3MA = 6");
         quatroDif5_assertividadeKatana_INV = CalcularAssertividade_INV(quatroPara5_INVHorario_negociacao, katanaBarreira, quatroDif5_quantidadeVitoria_katanaINV, quatroDif5_quantidadeDerrota_katanaINV, porcentagemBarreira, quatroDif5_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, quatroDif5_entradasINV, "     4 <> 5");
         cincoDif6_assertividadeKatana_INV = CalcularAssertividade_INV(cincoPara6_INVHorario_negociacao, katanaBarreira, cincoDif6_quantidadeVitoria_katanaINV, cincoDif6_quantidadeDerrota_katanaINV, porcentagemBarreira, cincoDif6_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, cincoDif6_entradasINV, "     5 <> 6");
         seisDif1_assertividadeKatana_INV = CalcularAssertividade_INV(seisPara1_INVHorario_negociacao, katanaBarreira, seisDif1_quantidadeVitoria_katanaINV, seisDif1_quantidadeDerrota_katanaINV, porcentagemBarreira, seisDif1_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, seisDif1_entradasINV, "     6 <> 1");
         maioriaTres_meioDif5_assertividadeKatana_INV = CalcularAssertividade_INV(maioriaTres_meioPara5_INVHorario_negociacao, katanaBarreira, maioriaTres_meioDif5_quantidadeVitoria_katanaINV, maioriaTres_meioDif5_quantidadeDerrota_katanaINV, porcentagemBarreira, maioriaTres_meioDif5_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, maioriaTres_meioDif5_entradasINV, "  M3M <> 5");
         maioriaTres_meioM5_altDif6_assertividadeKatana_INV = CalcularAssertividade_INV(maioriaTres_meioM5_altPara6_INVHorario_negociacao, katanaBarreira, maioriaTres_meioM5_altDif6_quantidadeVitoria_katanaINV, maioriaTres_meioM5_altDif6_quantidadeDerrota_katanaINV, porcentagemBarreira, maioriaTres_meioM5_altDif6_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, maioriaTres_meioM5_altDif6_entradasINV, "M3MA <> 6");
        }
      else
         if(velasPor_quadrante == 4)
           {
            quatroIgual1_assertividadeKatana_PDR = CalcularAssertividade_PDR(quatroPara1_PDRHorario_negociacao, katanaBarreira, quatroIgual1_quantidadeVitoria_katanaPDR, quatroIgual1_quantidadeDerrota_katanaPDR, porcentagemBarreira, quatroIgual1_porcentagemOcorrencias_PDR, limitePorcentagem_ocorrencias, quatroIgual1_entradasPDR, "      4 = 1");
            quatroDif1_assertividadeKatana_INV = CalcularAssertividade_PDR(quatroPara1_INVHorario_negociacao, katanaBarreira, quatroDif1_quantidadeVitoria_katanaINV, quatroDif1_quantidadeDerrota_katanaINV, porcentagemBarreira, quatroDif1_porcentagemOcorrencias_INV, limitePorcentagem_ocorrencias, quatroDif1_entradasINV, "     4 <> 1");
           }

//+------------------------------------------------------------------+
//| ORGANIZAÇÃO DA PORCENTAGEM DE ASSERTIVIDADE                      |
//+------------------------------------------------------------------+
   PrepararMatriz_DoubleDois(26, porcentagemAssertividade_organizada);
   PrepararVetor_Double(26, porcentagemAssertividade_vetor);
   PrepararVetor_Double(26, porcentagemAssertividade_titulo);

   for(int i = 0; i < ArrayRange(porcentagemAssertividade_organizada, 0); i++)
     {
      porcentagemAssertividade_organizada[i]
      [1] = i;
     }

   porcentagemAssertividade_organizada[0][0] = umIgual2_assertividadeKatana_PDR;
   porcentagemAssertividade_organizada[1][0] = umDif2_assertividadeKatana_INV;
   porcentagemAssertividade_organizada[2][0] = doisIgual3_assertividadeKatana_PDR;
   porcentagemAssertividade_organizada[3][0] = doisDif3_assertividadeKatana_INV;
   porcentagemAssertividade_organizada[4][0] = tresIgual4_assertividadeKatana_PDR;
   porcentagemAssertividade_organizada[5][0] = tresDif4_assertividadeKatana_INV;

   if(velasPor_quadrante == 4)
     {
      porcentagemAssertividade_organizada[6][0] = quatroIgual1_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[7][0] = quatroDif1_assertividadeKatana_INV;
     }
   else
     {
      porcentagemAssertividade_organizada[6][0] = -200;
      porcentagemAssertividade_organizada[7][0] = -200;
     }

   if(velasPor_quadrante == 5 || velasPor_quadrante == 6)
     {
      porcentagemAssertividade_organizada[8]
      [0] = quatroIgual5_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[9][0] = quatroDif5_assertividadeKatana_INV;
      porcentagemAssertividade_organizada[20][0] = maioriaTres_meioIgual5_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[21][0] = maioriaTres_meioDif5_assertividadeKatana_INV;
     }
   else
     {
      porcentagemAssertividade_organizada[8][0] = -200;
      porcentagemAssertividade_organizada[9][0] = -200;
      porcentagemAssertividade_organizada[20][0] = -200;
      porcentagemAssertividade_organizada[21][0] = -200;
     }

   if(velasPor_quadrante == 5)
     {
      porcentagemAssertividade_organizada[10][0] = cincoIgual1_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[11][0] = cincoDif1_assertividadeKatana_INV;
     }
   else
     {
      porcentagemAssertividade_organizada[10][0] = -200;
      porcentagemAssertividade_organizada[11][0] = -200;
     }

   if(velasPor_quadrante == 6)
     {
      porcentagemAssertividade_organizada[12][0] = cincoIgual6_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[13][0] = cincoDif6_assertividadeKatana_INV;
      porcentagemAssertividade_organizada[14][0] = seisIgual1_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[15][0] = seisDif1_assertividadeKatana_INV;
      porcentagemAssertividade_organizada[22][0] = maioriaTres_meioM5_altIgual6_assertividadeKatana_PDR;
      porcentagemAssertividade_organizada[23][0] = maioriaTres_meioM5_altDif6_assertividadeKatana_INV;
     }
   else
     {
      porcentagemAssertividade_organizada[12][0] = -200;
      porcentagemAssertividade_organizada[13][0] = -200;
      porcentagemAssertividade_organizada[14][0] = -200;
      porcentagemAssertividade_organizada[15][0] = -200;
      porcentagemAssertividade_organizada[22][0] = -200;
      porcentagemAssertividade_organizada[23][0] = -200;
     }

   porcentagemAssertividade_organizada[16][0] = maioriaVelas_igual1Assertividade_katanaPDR;
   porcentagemAssertividade_organizada[17][0] = maioriaVelas_dif1Assertividade_katanaINV;
   porcentagemAssertividade_organizada[18][0] = maioriaTres_primeirasIgual4_assertividadeKatana_PDR;
   porcentagemAssertividade_organizada[19][0] = maioriaTres_primeirasDif4_assertividadeKatana_INV;
   porcentagemAssertividade_organizada[24][0] = maioriaTres_ultimasIgual1_assertividadeKatana_PDR;
   porcentagemAssertividade_organizada[25][0] = maioriaTres_ultimasDif1_assertividadeKatana_INV;

//--- Organização da Tabela de Assertividade
   ArraySort(porcentagemAssertividade_organizada);
   ReverterMatriz_DoubleColuna1(porcentagemAssertividade_vetor, porcentagemAssertividade_organizada);
   ReverterMatriz_DoubleColuna2(porcentagemAssertividade_titulo, porcentagemAssertividade_organizada);

//+------------------------------------------------------------------+
//| TABELA FINAL DE ASSERTIVIDADE                                    |
//+------------------------------------------------------------------+
   for(int i = 0; i < ArrayRange(tabelaFinal_assertividade, 0); i++)
     {
      tabelaFinal_assertividade[i][0] = StringFormat("%02i", i+1) + "º";
      switch((int)porcentagemAssertividade_titulo[i])
        {
         case 0:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "1 = 2 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "1 = 2/3 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "1 = 2/3/4 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(umIgual2_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(umIgual2_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(umIgual2_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 1:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "1 <> 2 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "1 <> 2/3 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "1 <> 2/3/4 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(umDif2_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(umDif2_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(umDif2_assertividadeKatana_INV, 2) + "%)";
            break;
         case 2:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "2 = 3 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "2 = 3/4 (PDR)";
                 }
               else
                  if(posicoes == 3 && velasPor_quadrante != 4)
                    {
                     tabelaFinal_assertividade[i][1] = "2 = 3/4/5 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_assertividade[i][1] = "2 = 3/4/1 (PDR)";
                       }
            tabelaFinal_assertividade[i][2] = DoubleToString(doisIgual3_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(doisIgual3_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(doisIgual3_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 3:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "2 <> 3 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "2 <> 3/4 (INV)";
                 }
               else
                  if(posicoes == 3 && velasPor_quadrante != 4)
                    {
                     tabelaFinal_assertividade[i][1] = "2 <> 3/4/5 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_assertividade[i][1] = "2 <> 3/4/1 (INV)";
                       }
            tabelaFinal_assertividade[i][2] = DoubleToString(doisDif3_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(doisDif3_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(doisDif3_assertividadeKatana_INV, 2) + "%)";
            break;
         case 4:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "3 = 4 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_assertividade[i][1] = "3 = 4/5 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_assertividade[i][1] = "3 = 4/1 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_assertividade[i][1] = "3 = 4/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_assertividade[i][1] = "3 = 4/5/1 (PDR)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_assertividade[i][1] = "3 = 4/5/6 (PDR)";
                             }
            tabelaFinal_assertividade[i][2] = DoubleToString(tresIgual4_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(tresIgual4_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(tresIgual4_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 5:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "3 <> 4 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_assertividade[i][1] = "3 <> 4/5 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_assertividade[i][1] = "3 <> 4/1 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_assertividade[i][1] = "3 <> 4/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_assertividade[i][1] = "3 <> 4/5/1 (INV)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_assertividade[i][1] = "3 <> 4/5/6 (INV)";
                             }
            tabelaFinal_assertividade[i][2] = DoubleToString(tresDif4_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(tresDif4_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(tresDif4_assertividadeKatana_INV, 2) + "%)";
            break;
         case 6:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "4 = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "4 = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "4 = 1/2/3 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(quatroIgual1_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(quatroIgual1_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(quatroIgual1_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 7:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "4 <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "4 <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "4 <> 1/2/3 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(quatroDif1_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(quatroDif1_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(quatroDif1_assertividadeKatana_INV, 2) + "%)";
            break;
         case 8:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "4 = 5 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_assertividade[i][1] = "4 = 5/1 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_assertividade[i][1] = "4 = 5/6 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_assertividade[i][1] = "4 = 5/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_assertividade[i][1] = "4 = 5/6/1 (PDR)";
                          }
            tabelaFinal_assertividade[i][2] = DoubleToString(quatroIgual5_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(quatroIgual5_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(quatroIgual5_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 9:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "4 <> 5 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_assertividade[i][1] = "4 <> 5/1 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_assertividade[i][1] = "4 <> 5/6 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_assertividade[i][1] = "4 <> 5/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_assertividade[i][1] = "4 <> 5/6/1 (INV)";
                          }
            tabelaFinal_assertividade[i][2] = DoubleToString(quatroDif5_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(quatroDif5_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(quatroDif5_assertividadeKatana_INV, 2) + "%)";
            break;
         case 10:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "5 = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "5 = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "5 = 1/2/3 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(cincoIgual1_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(cincoIgual1_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(cincoIgual1_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 11:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "5 <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "5 <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "5 <> 1/2/3 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(cincoDif1_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(cincoDif1_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(cincoDif1_assertividadeKatana_INV, 2) + "%)";
            break;
         case 12:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "5 = 6 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "5 = 6/1 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "5 = 6/1/2 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(cincoIgual6_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(cincoIgual6_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(cincoIgual6_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 13:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "5 <> 6 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "5 <> 6/1 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "5 <> 6/1/2 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(cincoDif6_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(cincoDif6_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(cincoDif6_assertividadeKatana_INV, 2) + "%)";
            break;
         case 14:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "6 = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "6 = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "6 = 1/2/3 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(seisIgual1_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(seisIgual1_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(seisIgual1_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 15:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "6 <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "6 <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "6 <> 1/2/3 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(seisDif1_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(seisDif1_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(seisDif1_assertividadeKatana_INV, 2) + "%)";
            break;
         case 16:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (Quadrante) = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (Quadrante) = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (Quadrante) = 1/2/3 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaVelas_igual1Quantidade_vitoriaKatana_PDR, 0) + " V / " + DoubleToString(maioriaVelas_igual1Quantidade_derrotaKatana_PDR, 0) + " D  (" + DoubleToString(maioriaVelas_igual1Assertividade_katanaPDR, 2) + "%)";
            break;
         case 17:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (Quadrante) <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (Quadrante) <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (Quadrante) <> 1/2/3 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaVelas_dif1Quantidade_vitoriaKatana_INV, 0) + " V / " + DoubleToString(maioriaVelas_dif1Quantidade_derrotaKatana_INV, 0) + " D  (" + DoubleToString(maioriaVelas_dif1Assertividade_katanaINV, 2) + "%)";
            break;
         case 18:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) = 4 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) = 4/5 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) = 4/1 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) = 4/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) = 4/5/1 (PDR)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) = 4/5/6 (PDR)";
                             }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_primeirasIgual4_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(maioriaTres_primeirasIgual4_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(maioriaTres_primeirasIgual4_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 19:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) <> 4 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante != 4)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) <> 4/5 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 4)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) <> 4/1 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 4)
                       {
                        tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) <> 4/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 5)
                          {
                           tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) <> 4/5/1 (INV)";
                          }
                        else
                           if(posicoes == 3 && velasPor_quadrante == 6)
                             {
                              tabelaFinal_assertividade[i][1] = "Maioria (3 Primeiras) <> 4/5/6 (INV)";
                             }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_primeirasDif4_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(maioriaTres_primeirasDif4_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(maioriaTres_primeirasDif4_assertividadeKatana_INV, 2) + "%)";
            break;
         case 20:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) = 5 (PDR)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) = 5/1 (PDR)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) = 5/6 (PDR)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) = 5/1/2 (PDR)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) = 5/6/1 (PDR)";
                          }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_meioIgual5_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(maioriaTres_meioIgual5_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(maioriaTres_meioIgual5_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 21:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) <> 5 (INV)";
              }
            else
               if(posicoes == 2 && velasPor_quadrante == 5)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) <> 5/1 (INV)";
                 }
               else
                  if(posicoes == 2 && velasPor_quadrante == 6)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) <> 5/6 (INV)";
                    }
                  else
                     if(posicoes == 3 && velasPor_quadrante == 5)
                       {
                        tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) <> 5/1/2 (INV)";
                       }
                     else
                        if(posicoes == 3 && velasPor_quadrante == 6)
                          {
                           tabelaFinal_assertividade[i][1] = "Maioria (3 Meio) <> 5/6/1 (INV)";
                          }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_meioDif5_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(maioriaTres_meioDif5_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(maioriaTres_meioDif5_assertividadeKatana_INV, 2) + "%)";
            break;
         case 22:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Meio M5 Alt) = 6 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Meio M5 Alt) = 6/1 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Meio M5 Alt) = 6/1/2 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_meioM5_altIgual6_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(maioriaTres_meioM5_altIgual6_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(maioriaTres_meioM5_altIgual6_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 23:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Meio M5 Alt) <> 6 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Meio M5 Alt) <> 6/1 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Meio M5 Alt) <> 6/1/2 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_meioM5_altDif6_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(maioriaTres_meioM5_altDif6_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(maioriaTres_meioM5_altDif6_assertividadeKatana_INV, 2) + "%)";
            break;
         case 24:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Últimas) = 1 (PDR)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Últimas) = 1/2 (PDR)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Últimas) = 1/2/3 (PDR)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_ultimasIgual1_quantidadeVitoria_katanaPDR, 0) + " V / " + DoubleToString(maioriaTres_ultimasIgual1_quantidadeDerrota_katanaPDR, 0) + " D  (" + DoubleToString(maioriaTres_ultimasIgual1_assertividadeKatana_PDR, 2) + "%)";
            break;
         case 25:
            if(posicoes == 1)
              {
               tabelaFinal_assertividade[i][1] = "Maioria (3 Últimas) <> 1 (INV)";
              }
            else
               if(posicoes == 2)
                 {
                  tabelaFinal_assertividade[i][1] = "Maioria (3 Últimas) <> 1/2 (INV)";
                 }
               else
                  if(posicoes == 3)
                    {
                     tabelaFinal_assertividade[i][1] = "Maioria (3 Últimas) <> 1/2/3 (INV)";
                    }
            tabelaFinal_assertividade[i][2] = DoubleToString(maioriaTres_ultimasDif1_quantidadeVitoria_katanaINV, 0) + " V / " + DoubleToString(maioriaTres_ultimasDif1_quantidadeDerrota_katanaINV, 0) + " D  (" + DoubleToString(maioriaTres_ultimasDif1_assertividadeKatana_INV, 2) + "%)";
            break;
        }
     }

//+------------------------------------------------------------------+
//| TABELA DE HISTÓRICO DE ENTRADAS                                  |
//+------------------------------------------------------------------+
   if(velasPor_quadrante == 5)
     {
      numeroLinhas_historicoEntradas = ArrayRange(umIgual2_entradasPDR, 0) +
                                       ArrayRange(doisIgual3_entradasPDR, 0) +
                                       ArrayRange(tresIgual4_entradasPDR, 0) +
                                       ArrayRange(quatroIgual5_entradasPDR, 0) +
                                       ArrayRange(cincoIgual1_entradasPDR, 0) +
                                       ArrayRange(maioriaVelas_igual1Entradas_PDR, 0) +
                                       ArrayRange(maioriaTres_primeirasIgual4_entradasPDR, 0) +
                                       ArrayRange(maioriaTres_meioIgual5_entradasPDR, 0) +
                                       ArrayRange(maioriaTres_ultimasIgual1_entradasPDR, 0) +
                                       ArrayRange(umDif2_entradasINV, 0) +
                                       ArrayRange(doisDif3_entradasINV, 0) +
                                       ArrayRange(tresDif4_entradasINV, 0) +
                                       ArrayRange(quatroDif5_entradasINV, 0) +
                                       ArrayRange(cincoDif1_entradasINV, 0) +
                                       ArrayRange(maioriaVelas_dif1Entradas_INV, 0) +
                                       ArrayRange(maioriaTres_primeirasDif4_entradasINV, 0) +
                                       ArrayRange(maioriaTres_meioDif5_entradasINV, 0) +
                                       ArrayRange(maioriaTres_ultimasDif1_entradasINV, 0);
     }
   else
      if(velasPor_quadrante == 6)
        {
         numeroLinhas_historicoEntradas = ArrayRange(umIgual2_entradasPDR, 0) +
                                          ArrayRange(doisIgual3_entradasPDR, 0) +
                                          ArrayRange(tresIgual4_entradasPDR, 0) +
                                          ArrayRange(quatroIgual5_entradasPDR, 0) +
                                          ArrayRange(cincoIgual6_entradasPDR, 0) +
                                          ArrayRange(seisIgual1_entradasPDR, 0) +
                                          ArrayRange(maioriaVelas_igual1Entradas_PDR, 0) +
                                          ArrayRange(maioriaTres_primeirasIgual4_entradasPDR, 0) +
                                          ArrayRange(maioriaTres_meioIgual5_entradasPDR, 0) +
                                          ArrayRange(maioriaTres_meioM5_altIgual6_entradasPDR, 0) +
                                          ArrayRange(maioriaTres_ultimasIgual1_entradasPDR, 0) +
                                          ArrayRange(umDif2_entradasINV, 0) +
                                          ArrayRange(doisDif3_entradasINV, 0) +
                                          ArrayRange(tresDif4_entradasINV, 0) +
                                          ArrayRange(quatroDif5_entradasINV, 0) +
                                          ArrayRange(cincoDif6_entradasINV, 0) +
                                          ArrayRange(seisDif1_entradasINV, 0) +
                                          ArrayRange(maioriaVelas_dif1Entradas_INV, 0) +
                                          ArrayRange(maioriaTres_primeirasDif4_entradasINV, 0) +
                                          ArrayRange(maioriaTres_meioDif5_entradasINV, 0) +
                                          ArrayRange(maioriaTres_meioM5_altDif6_entradasINV, 0) +
                                          ArrayRange(maioriaTres_ultimasDif1_entradasINV, 0);
        }
      else
         if(velasPor_quadrante == 4)
           {
            numeroLinhas_historicoEntradas = ArrayRange(umIgual2_entradasPDR, 0) +
                                             ArrayRange(doisIgual3_entradasPDR, 0) +
                                             ArrayRange(tresIgual4_entradasPDR, 0) +
                                             ArrayRange(quatroIgual1_entradasPDR, 0) +
                                             ArrayRange(maioriaVelas_igual1Entradas_PDR, 0) +
                                             ArrayRange(maioriaTres_primeirasIgual4_entradasPDR, 0) +
                                             ArrayRange(maioriaTres_ultimasIgual1_entradasPDR, 0) +
                                             ArrayRange(umDif2_entradasINV, 0) +
                                             ArrayRange(doisDif3_entradasINV, 0) +
                                             ArrayRange(tresDif4_entradasINV, 0) +
                                             ArrayRange(quatroDif1_entradasINV, 0) +
                                             ArrayRange(maioriaVelas_dif1Entradas_INV, 0) +
                                             ArrayRange(maioriaTres_primeirasDif4_entradasINV, 0) +
                                             ArrayRange(maioriaTres_ultimasDif1_entradasINV, 0);
           }

   ArrayResize(tabelaFinal_historicoEntradas, numeroLinhas_historicoEntradas, 0);

   if(velasPor_quadrante == 5)
     {
      AglutinarMatrizes_StringM1(umIgual2_entradasPDR, doisIgual3_entradasPDR, tresIgual4_entradasPDR, quatroIgual5_entradasPDR,
                                 cincoIgual1_entradasPDR, maioriaVelas_igual1Entradas_PDR, maioriaTres_primeirasIgual4_entradasPDR,
                                 maioriaTres_meioIgual5_entradasPDR, maioriaTres_ultimasIgual1_entradasPDR,
                                 umDif2_entradasINV, doisDif3_entradasINV, tresDif4_entradasINV, quatroDif5_entradasINV,
                                 cincoDif1_entradasINV, maioriaVelas_dif1Entradas_INV, maioriaTres_primeirasDif4_entradasINV,
                                 maioriaTres_meioDif5_entradasINV, maioriaTres_ultimasDif1_entradasINV,
                                 tabelaFinal_historicoEntradas);
     }
   else
      if(velasPor_quadrante == 6)
        {
         AglutinarMatrizes_StringM5(umIgual2_entradasPDR, doisIgual3_entradasPDR, tresIgual4_entradasPDR, quatroIgual5_entradasPDR,
                                    cincoIgual6_entradasPDR, seisIgual1_entradasPDR, maioriaVelas_igual1Entradas_PDR,
                                    maioriaTres_primeirasIgual4_entradasPDR, maioriaTres_meioIgual5_entradasPDR,
                                    maioriaTres_meioM5_altIgual6_entradasPDR,maioriaTres_ultimasIgual1_entradasPDR,
                                    umDif2_entradasINV, doisDif3_entradasINV, tresDif4_entradasINV, quatroDif5_entradasINV,
                                    cincoDif6_entradasINV, seisDif1_entradasINV, maioriaVelas_dif1Entradas_INV,
                                    maioriaTres_primeirasDif4_entradasINV, maioriaTres_meioDif5_entradasINV,
                                    maioriaTres_meioM5_altDif6_entradasINV, maioriaTres_ultimasDif1_entradasINV,
                                    tabelaFinal_historicoEntradas);
        }
      else
         if(velasPor_quadrante == 4)
           {
            AglutinarMatrizes_StringM15(umIgual2_entradasPDR, doisIgual3_entradasPDR, tresIgual4_entradasPDR,
                                        quatroIgual1_entradasPDR, maioriaVelas_igual1Entradas_PDR,
                                        maioriaTres_primeirasIgual4_entradasPDR, maioriaTres_ultimasIgual1_entradasPDR,
                                        umDif2_entradasINV,doisDif3_entradasINV, tresDif4_entradasINV,
                                        quatroDif1_entradasINV, maioriaVelas_dif1Entradas_INV,
                                        maioriaTres_primeirasDif4_entradasINV, maioriaTres_ultimasDif1_entradasINV,
                                        tabelaFinal_historicoEntradas);
           }

   string   historicoEntradas_auxiliar[1][4];

   for(int  contadorHistorico_entradas = 1; contadorHistorico_entradas < ArrayRange(tabelaFinal_historicoEntradas, 0); contadorHistorico_entradas++)
     {
      for(int i = 0; i < ArrayRange(tabelaFinal_historicoEntradas, 0) - 1; i++)
        {
         if(StringToTime(tabelaFinal_historicoEntradas[i][1]) > StringToTime(tabelaFinal_historicoEntradas[i + 1][1]))
           {
            historicoEntradas_auxiliar[0][0] = tabelaFinal_historicoEntradas[i][0];
            historicoEntradas_auxiliar[0][1] = tabelaFinal_historicoEntradas[i][1];
            historicoEntradas_auxiliar[0][2] = tabelaFinal_historicoEntradas[i][2];
            historicoEntradas_auxiliar[0][3] = tabelaFinal_historicoEntradas[i][3];

            tabelaFinal_historicoEntradas[i][0] = tabelaFinal_historicoEntradas[i + 1][0];
            tabelaFinal_historicoEntradas[i][1] = tabelaFinal_historicoEntradas[i + 1][1];
            tabelaFinal_historicoEntradas[i][2] = tabelaFinal_historicoEntradas[i + 1][2];
            tabelaFinal_historicoEntradas[i][3] = tabelaFinal_historicoEntradas[i + 1][3];

            tabelaFinal_historicoEntradas[i + 1][0] = historicoEntradas_auxiliar[0][0];
            tabelaFinal_historicoEntradas[i + 1][1] = historicoEntradas_auxiliar[0][1];
            tabelaFinal_historicoEntradas[i + 1][2] = historicoEntradas_auxiliar[0][2];
            tabelaFinal_historicoEntradas[i + 1][3] = historicoEntradas_auxiliar[0][3];
           }
        }
     }

//+------------------------------------------------------------------+
//| CÁLCULO DE VITÓRIAS E DERROTAS (TOTAL)                           |
//+------------------------------------------------------------------+
   if(velasPor_quadrante == 5)
     {
      quantidadeVitorias_total = umIgual2_quantidadeVitoria_katanaPDR + doisIgual3_quantidadeVitoria_katanaPDR +
                                 tresIgual4_quantidadeVitoria_katanaPDR + quatroIgual5_quantidadeVitoria_katanaPDR +
                                 cincoIgual1_quantidadeVitoria_katanaPDR +
                                 maioriaVelas_igual1Quantidade_vitoriaKatana_PDR +
                                 maioriaTres_primeirasIgual4_quantidadeVitoria_katanaPDR +
                                 maioriaTres_meioIgual5_quantidadeVitoria_katanaPDR +
                                 maioriaTres_ultimasIgual1_quantidadeVitoria_katanaPDR +
                                 umDif2_quantidadeVitoria_katanaINV + doisDif3_quantidadeVitoria_katanaINV +
                                 tresDif4_quantidadeVitoria_katanaINV + quatroDif5_quantidadeVitoria_katanaINV +
                                 cincoDif1_quantidadeVitoria_katanaINV +
                                 maioriaVelas_dif1Quantidade_vitoriaKatana_INV +
                                 maioriaTres_primeirasDif4_quantidadeVitoria_katanaINV +
                                 maioriaTres_meioDif5_quantidadeVitoria_katanaINV +
                                 maioriaTres_ultimasDif1_quantidadeVitoria_katanaINV;

      quantidadeDerrotas_total = umIgual2_quantidadeDerrota_katanaPDR + doisIgual3_quantidadeDerrota_katanaPDR +
                                 tresIgual4_quantidadeDerrota_katanaPDR + quatroIgual5_quantidadeDerrota_katanaPDR +
                                 cincoIgual1_quantidadeDerrota_katanaPDR +
                                 maioriaVelas_igual1Quantidade_derrotaKatana_PDR +
                                 maioriaTres_primeirasIgual4_quantidadeDerrota_katanaPDR +
                                 maioriaTres_meioIgual5_quantidadeDerrota_katanaPDR +
                                 maioriaTres_ultimasIgual1_quantidadeDerrota_katanaPDR +
                                 umDif2_quantidadeDerrota_katanaINV + doisDif3_quantidadeDerrota_katanaINV +
                                 tresDif4_quantidadeDerrota_katanaINV + quatroDif5_quantidadeDerrota_katanaINV +
                                 cincoDif1_quantidadeDerrota_katanaINV +
                                 maioriaVelas_dif1Quantidade_derrotaKatana_INV +
                                 maioriaTres_primeirasDif4_quantidadeDerrota_katanaINV +
                                 maioriaTres_meioDif5_quantidadeDerrota_katanaINV +
                                 maioriaTres_ultimasDif1_quantidadeDerrota_katanaINV;
     }
   else
      if(velasPor_quadrante == 6)
        {
         quantidadeVitorias_total = umIgual2_quantidadeVitoria_katanaPDR + doisIgual3_quantidadeVitoria_katanaPDR +
                                    tresIgual4_quantidadeVitoria_katanaPDR + quatroIgual5_quantidadeVitoria_katanaPDR +
                                    cincoIgual6_quantidadeVitoria_katanaPDR + seisIgual1_quantidadeVitoria_katanaPDR +
                                    maioriaVelas_igual1Quantidade_vitoriaKatana_PDR +
                                    maioriaTres_primeirasIgual4_quantidadeVitoria_katanaPDR +
                                    maioriaTres_meioIgual5_quantidadeVitoria_katanaPDR +
                                    maioriaTres_meioM5_altIgual6_quantidadeVitoria_katanaPDR +
                                    maioriaTres_ultimasIgual1_quantidadeVitoria_katanaPDR +
                                    umDif2_quantidadeVitoria_katanaINV + doisDif3_quantidadeVitoria_katanaINV +
                                    tresDif4_quantidadeVitoria_katanaINV + quatroDif5_quantidadeVitoria_katanaINV +
                                    cincoDif6_quantidadeVitoria_katanaINV + seisDif1_quantidadeVitoria_katanaINV +
                                    maioriaVelas_dif1Quantidade_vitoriaKatana_INV +
                                    maioriaTres_primeirasDif4_quantidadeVitoria_katanaINV +
                                    maioriaTres_meioDif5_quantidadeVitoria_katanaINV +
                                    maioriaTres_meioM5_altDif6_quantidadeVitoria_katanaINV +
                                    maioriaTres_ultimasDif1_quantidadeVitoria_katanaINV;

         quantidadeDerrotas_total = umIgual2_quantidadeDerrota_katanaPDR + doisIgual3_quantidadeDerrota_katanaPDR +
                                    tresIgual4_quantidadeDerrota_katanaPDR + quatroIgual5_quantidadeDerrota_katanaPDR +
                                    cincoIgual6_quantidadeDerrota_katanaPDR + seisIgual1_quantidadeDerrota_katanaPDR +
                                    maioriaVelas_igual1Quantidade_derrotaKatana_PDR +
                                    maioriaTres_primeirasIgual4_quantidadeDerrota_katanaPDR +
                                    maioriaTres_meioIgual5_quantidadeDerrota_katanaPDR +
                                    maioriaTres_meioM5_altIgual6_quantidadeDerrota_katanaPDR +
                                    maioriaTres_ultimasIgual1_quantidadeDerrota_katanaPDR +
                                    umDif2_quantidadeDerrota_katanaINV + doisDif3_quantidadeDerrota_katanaINV +
                                    tresDif4_quantidadeDerrota_katanaINV + quatroDif5_quantidadeDerrota_katanaINV +
                                    cincoDif6_quantidadeDerrota_katanaINV + seisDif1_quantidadeDerrota_katanaINV +
                                    maioriaVelas_dif1Quantidade_derrotaKatana_INV +
                                    maioriaTres_primeirasDif4_quantidadeDerrota_katanaINV +
                                    maioriaTres_meioDif5_quantidadeDerrota_katanaINV +
                                    maioriaTres_meioM5_altDif6_quantidadeDerrota_katanaINV +
                                    maioriaTres_ultimasDif1_quantidadeDerrota_katanaINV;
        }
      else
         if(velasPor_quadrante == 4)
           {
            quantidadeVitorias_total = umIgual2_quantidadeVitoria_katanaPDR + doisIgual3_quantidadeVitoria_katanaPDR +
                                       tresIgual4_quantidadeVitoria_katanaPDR + quatroIgual1_quantidadeVitoria_katanaPDR +
                                       maioriaVelas_igual1Quantidade_vitoriaKatana_PDR +
                                       maioriaTres_primeirasIgual4_quantidadeVitoria_katanaPDR +
                                       maioriaTres_ultimasIgual1_quantidadeVitoria_katanaPDR +
                                       umDif2_quantidadeVitoria_katanaINV + doisDif3_quantidadeVitoria_katanaINV +
                                       tresDif4_quantidadeVitoria_katanaINV + quatroDif1_quantidadeVitoria_katanaINV +
                                       maioriaVelas_dif1Quantidade_vitoriaKatana_INV +
                                       maioriaTres_primeirasDif4_quantidadeVitoria_katanaINV +
                                       maioriaTres_ultimasDif1_quantidadeVitoria_katanaINV;

            quantidadeDerrotas_total = umIgual2_quantidadeDerrota_katanaPDR + doisIgual3_quantidadeDerrota_katanaPDR +
                                       tresIgual4_quantidadeDerrota_katanaPDR + quatroIgual1_quantidadeDerrota_katanaPDR +
                                       maioriaVelas_igual1Quantidade_derrotaKatana_PDR +
                                       maioriaTres_primeirasIgual4_quantidadeDerrota_katanaPDR +
                                       maioriaTres_ultimasIgual1_quantidadeDerrota_katanaPDR +
                                       umDif2_quantidadeDerrota_katanaINV + doisDif3_quantidadeDerrota_katanaINV +
                                       tresDif4_quantidadeDerrota_katanaINV + quatroDif1_quantidadeDerrota_katanaINV +
                                       maioriaVelas_dif1Quantidade_derrotaKatana_INV +
                                       maioriaTres_primeirasDif4_quantidadeDerrota_katanaINV +
                                       maioriaTres_ultimasDif1_quantidadeDerrota_katanaINV;
           }

   if(quantidadeVitorias_total + quantidadeDerrotas_total != 0)
     {
      NormalizeDouble(assertividadeCombinada = (quantidadeVitorias_total / (quantidadeVitorias_total - quantidadeDerrotas_total)) * 100, 2);
     }
   else
      if(quantidadeVitorias_total + quantidadeDerrotas_total == 0 &&
         (quantidadeVitorias_total > 0 ||
          quantidadeDerrotas_total > 0))
        {
         NormalizeDouble(assertividadeCombinada = 50, 2);
        }
      else
        {
         assertividadeCombinada = 0;
        }

//+------------------------------------------------------------------+
//| PAINEL 1 (TÍTULOS E VALORES)                                     |
//+------------------------------------------------------------------+
//--- Legendas Botão 1
   PrepararVetor_String(ArrayRange(legendasPainel1_botao1Vertical, 0), legendasPainel1_botao1Vertical_label);
   for(int i = 0; i < ArrayRange(legendasPainel1_botao1Vertical, 0); i++)
     {
      legendasPainel1_botao1Vertical_label[i]
         = "legendaPainel1_botao1Vertical." + IntegerToString(i);
     }

//--- Valores Botão 1
   valoresPainel1_botao1[0] = DoubleToString(velasVerdes, 0);
   valoresPainel1_botao1[1] = DoubleToString(velasVermelhas, 0);
   valoresPainel1_botao1[2] = DoubleToString(dojis, 0);
   valoresPainel1_botao1[3] = DoubleToString(velasVerdes_porcentagem, 2) + "%";
   valoresPainel1_botao1[4] = DoubleToString(velasVermelhas_porcentagem, 2) + "%";
   valoresPainel1_botao1[5] = DoubleToString(dojisPorcentagem, 2) + "%";
   valoresPainel1_botao1[6] = IntegerToString(numeroLinhas);
   ArrayReverse(valoresPainel1_botao1);

   for(int i = 0; i < ArrayRange(valoresPainel1_botao1, 0); i++)
     {
      valoresPainel1_botao1Label[i]
         = "valorPainel1_botao1." + IntegerToString(i);
     }

//--- Legendas Botão 2
   PrepararVetor_String(numeroLinhas, legendasPainel1_botao2Vertical);

   if(velasPor_quadrante == 5)
     {
      for(int i = 0; i < numeroLinhas; i++)
        {
         TimeToStruct(periodoVelas_quadrante5[i][0], legendasPainel1_botao2Vertical_estrutura);
         legendasPainel1_botao2Vertical[i] = StringFormat("%02i/%02i/%4i %s",
                                             legendasPainel1_botao2Vertical_estrutura.day,
                                             legendasPainel1_botao2Vertical_estrutura.mon,
                                             legendasPainel1_botao2Vertical_estrutura.year,
                                             TimeToString(StructToTime(legendasPainel1_botao2Vertical_estrutura), TIME_MINUTES));
        }
      for(int i = 0; i < ArraySize(legendasPainel1_botao2Horizontal_M1); i++)
        {
         legendasPainel1_botao2Horizontal_M1Label[i] = "legendasPainel1_botao2Horizontal_M1." + IntegerToString(i);
        }
     }
   else
      if(velasPor_quadrante == 6)
        {
         for(int i = 0; i < numeroLinhas; i++)
           {
            TimeToStruct(periodoVelas_quadrante6[i][0], legendasPainel1_botao2Vertical_estrutura);
            legendasPainel1_botao2Vertical[i] = StringFormat("%02i/%02i/%4i %s",
                                                legendasPainel1_botao2Vertical_estrutura.day,
                                                legendasPainel1_botao2Vertical_estrutura.mon,
                                                legendasPainel1_botao2Vertical_estrutura.year,
                                                TimeToString(StructToTime(legendasPainel1_botao2Vertical_estrutura), TIME_MINUTES));
           }
         for(int i = 0; i < ArraySize(legendasPainel1_botao2Horizontal_M5); i++)
           {
            legendasPainel1_botao2Horizontal_M5Label[i] = "legendasPainel1_botao2Horizontal_M5." + IntegerToString(i);
           }
        }
      else
         if(velasPor_quadrante == 4)
           {
            for(int i = 0; i < numeroLinhas; i++)
              {
               TimeToStruct(periodoVelas_quadrante4[i][0], legendasPainel1_botao2Vertical_estrutura);
               legendasPainel1_botao2Vertical[i] = StringFormat("%02i/%02i/%4i %s",
                                                   legendasPainel1_botao2Vertical_estrutura.day,
                                                   legendasPainel1_botao2Vertical_estrutura.mon,
                                                   legendasPainel1_botao2Vertical_estrutura.year,
                                                   TimeToString(StructToTime(legendasPainel1_botao2Vertical_estrutura), TIME_MINUTES));
              }
            for(int i = 0; i < ArraySize(legendasPainel1_botao2Horizontal_M15); i++)
              {
               legendasPainel1_botao2Horizontal_M15Label[i] = "legendasPainel1_botao2Horizontal_M15." + IntegerToString(i);
              }
           }

   PrepararVetor_String(numeroLinhas, legendasPainel1_botao2Vertical_label);
   for(int i = 0; i < numeroLinhas; i++)
     {
      legendasPainel1_botao2Vertical_label[i]
         = "legendaPainel1_botao2Vertical." + IntegerToString(i);
     }
   ArrayReverse(legendasPainel1_botao2Vertical_label);

//--- Legendas e Valores Botão 2
   if(velasPor_quadrante == 5)
     {
      PrepararMatriz_StringCinco(numeroLinhas, valoresPainel1_botao2M1);
      PrepararMatriz_StringCinco(numeroLinhas, valoresPainel1_botao2Label_M1);
      PrepararVetor_String(numeroLinhas, valoresPainel1_botao2MaioriaQ_M1Label);
      PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3primeirasM1_label);
      PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3meioM1_label);
      PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3ultimasM1_label);

      for(int i = 0; i < numeroLinhas; i++)
        {
         for(int j = 0; j < 5; j++)
           {
            valoresPainel1_botao2M1[i][j] = IntegerToString(quadranteVelas_5[i][j]);
            valoresPainel1_botao2Label_M1[i][j] = "valorPainel1_botao2." + IntegerToString(i) + "." + IntegerToString(j);
           }
        }
      for(int i = 0; i < numeroLinhas; i++)
        {
         valoresPainel1_botao2MaioriaQ_M1Label[i] = "valoresPainel1_botao2MaioriaQ_M1." + IntegerToString(i);
         valoresPainel1_botao2Maioria_3primeirasM1_label[i] = "valoresPainel1_botao2Maioria_3primeirasM1_label." + IntegerToString(i);
         valoresPainel1_botao2Maioria_3meioM1_label[i] = "valoresPainel1_botao2Maioria_3meioM1_label." + IntegerToString(i);
         valoresPainel1_botao2Maioria_3ultimasM1_label[i] = "valoresPainel1_botao2Maioria_3ultimasM1_label." + IntegerToString(i);
        }
     }
   else
      if(velasPor_quadrante == 6)
        {
         PrepararMatriz_StringSeis(numeroLinhas, valoresPainel1_botao2M5);
         PrepararMatriz_StringSeis(numeroLinhas, valoresPainel1_botao2Label_M5);
         PrepararVetor_String(numeroLinhas, valoresPainel1_botao2MaioriaQ_M5Label);
         PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3primeirasM5_label);
         PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3meioM5_label);
         PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3meioM5_altLabel);
         PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3ultimasM5_label);

         for(int i = 0; i < numeroLinhas; i++)
           {
            for(int j = 0; j < 6; j++)
              {
               valoresPainel1_botao2M5[i][j] = IntegerToString(quadranteVelas_6[i][j]);
               valoresPainel1_botao2Label_M5[i][j] = "valorPainel1_botao2." + IntegerToString(i) + "." + IntegerToString(j);
              }
           }

         for(int i = 0; i < numeroLinhas; i++)
           {
            valoresPainel1_botao2MaioriaQ_M5Label[i] = "valoresPainel1_botao2MaioriaQ_M5." + IntegerToString(i);
            valoresPainel1_botao2Maioria_3primeirasM5_label[i] = "valoresPainel1_botao2Maioria_3primeirasM5_label." + IntegerToString(i);
            valoresPainel1_botao2Maioria_3meioM5_label[i] = "valoresPainel1_botao2Maioria_3meioM5_label." + IntegerToString(i);
            valoresPainel1_botao2Maioria_3meioM5_altLabel[i] = "valoresPainel1_botao2Maioria_3meioM5_altLabel." + IntegerToString(i);
            valoresPainel1_botao2Maioria_3ultimasM5_label[i] = "valoresPainel1_botao2Maioria_3ultimasM5_label." + IntegerToString(i);
           }
        }
      else
         if(velasPor_quadrante == 4)
           {
            PrepararMatriz_StringQuatro(numeroLinhas, valoresPainel1_botao2M15);
            PrepararMatriz_StringQuatro(numeroLinhas, valoresPainel1_botao2Label_M15);
            PrepararVetor_String(numeroLinhas, valoresPainel1_botao2MaioriaQ_M15Label);
            PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3primeirasM15_label);
            PrepararVetor_String(numeroLinhas, valoresPainel1_botao2Maioria_3ultimasM15_label);

            for(int i = 0; i < numeroLinhas; i++)
              {
               for(int j = 0; j < 4; j++)
                 {
                  valoresPainel1_botao2M15[i][j] = IntegerToString(quadranteVelas_4[i][j]);
                  valoresPainel1_botao2Label_M15[i][j] = "valorPainel1_botao2." + IntegerToString(i) + "." + IntegerToString(j);
                 }
              }

            for(int i = 0; i < numeroLinhas; i++)
              {
               valoresPainel1_botao2MaioriaQ_M15Label[i] = "valoresPainel1_botao2MaioriaQ_M15." + IntegerToString(i);
               valoresPainel1_botao2Maioria_3primeirasM15_label[i] = "valoresPainel1_botao2Maioria_3primeirasM15_label." + IntegerToString(i);
               valoresPainel1_botao2Maioria_3ultimasM15_label[i] = "valoresPainel1_botao2Maioria_3ultimasM15_label." + IntegerToString(i);
              }

           }

   for(int i = 0; i < 11; i++)
     {
      quadrantePainel1_botao2Label[i]
         = "quadrantePainel1_botao2Label." + IntegerToString(i);
     }

//--- Legendas e Valores Botão 3
   valoresPainel3_botao3[0] = "Média (%)";
   valoresPainel3_botao3[1] = "Ocorrências:";
   valoresPainel3_botao3[2] = DoubleToString(limitePorcentagem_ocorrencias, 2) + "%";

   for(int  i = 0; i < 3; i++)
     {
      valoresPainel3_botao3Label[i]
         = "valoresPainel3_botao3." + IntegerToString(i);
     }

   if(velasPor_quadrante == 5)
     {
      PrepararMatriz_StringQuatro(18, valoresPainel1_botao3Label);
      for(int i = 0; i < 18; i++)
        {
         valoresPainel1_botao3Label[i][0] = "legendasPainel1_botao3Vertical.0." + IntegerToString(i);
         valoresPainel1_botao3Label[i][1] = "legendasPainel1_botao3Vertical.1." + IntegerToString(i);
         valoresPainel1_botao3Label[i][2] = "legendasPainel1_botao3Vertical.2." + IntegerToString(i);
         valoresPainel1_botao3Label[i][3] = "legendasPainel1_botao3Vertical.3." + IntegerToString(i);
        }
     }
   else
      if(velasPor_quadrante == 6)
        {
         PrepararMatriz_StringQuatro(22, valoresPainel1_botao3Label);
         for(int i = 0; i < 22; i++)
           {
            valoresPainel1_botao3Label[i][0] = "legendasPainel1_botao3Vertical.0." + IntegerToString(i);
            valoresPainel1_botao3Label[i][1] = "legendasPainel1_botao3Vertical.1." + IntegerToString(i);
            valoresPainel1_botao3Label[i][2] = "legendasPainel1_botao3Vertical.2." + IntegerToString(i);
            valoresPainel1_botao3Label[i][3] = "legendasPainel1_botao3Vertical.3." + IntegerToString(i);
           }
        }
      else
         if(velasPor_quadrante == 4)
           {
            PrepararMatriz_StringQuatro(14, valoresPainel1_botao3Label);
            for(int i = 0; i < 14; i++)
              {
               valoresPainel1_botao3Label[i][0] = "legendasPainel1_botao3Vertical.0." + IntegerToString(i);
               valoresPainel1_botao3Label[i][1] = "legendasPainel1_botao3Vertical.1." + IntegerToString(i);
               valoresPainel1_botao3Label[i][2] = "legendasPainel1_botao3Vertical.2." + IntegerToString(i);
               valoresPainel1_botao3Label[i][3] = "legendasPainel1_botao3Vertical.3." + IntegerToString(i);
              }
           }

//--- Legendas Botão 4
   for(int i = 0; i < ArrayRange(legendasPainel1_botao4Horizontal, 0); i++)
     {
      legendasPainel1_botao4Horizontal_label[i]
         = "legendaPainel1_botao4Horizontal." + IntegerToString(i);
     }

   PrepararMatriz_StringQuatro(ArrayRange(tabelaFinal_historicoEntradas, 0), valoresPainel1_botao4);
   for(int i = 0; i < ArrayRange(tabelaFinal_historicoEntradas, 0); i++)
     {
      valoresPainel1_botao4[i][0] = tabelaFinal_historicoEntradas[i][0];

      TimeToStruct(StringToTime(tabelaFinal_historicoEntradas[i][1]), valoresPainel1_botao4EstruturaInicio);
      valoresPainel1_botao4[i][1] = StringFormat("%02i/%02i/%4i %s",
                                    valoresPainel1_botao4EstruturaInicio.day,
                                    valoresPainel1_botao4EstruturaInicio.mon,
                                    valoresPainel1_botao4EstruturaInicio.year,
                                    TimeToString(StructToTime(valoresPainel1_botao4EstruturaInicio), TIME_MINUTES));

      TimeToStruct(StringToTime(tabelaFinal_historicoEntradas[i][2]), valoresPainel1_botao4EstruturaFim);
      valoresPainel1_botao4[i][2] = StringFormat("%02i/%02i/%4i %s",
                                    valoresPainel1_botao4EstruturaFim.day,
                                    valoresPainel1_botao4EstruturaFim.mon,
                                    valoresPainel1_botao4EstruturaFim.year,
                                    TimeToString(StructToTime(valoresPainel1_botao4EstruturaFim), TIME_MINUTES));


      valoresPainel1_botao4[i][3] = tabelaFinal_historicoEntradas[i][3];
     }

   PrepararMatriz_StringQuatro(ArrayRange(valoresPainel1_botao4, 0), valoresPainel1_botao4Label);
   for(int i = 0; i < ArrayRange(valoresPainel1_botao4Label, 0); i++)
     {
      for(int j = 0; j < 4; j++)
        {
         valoresPainel1_botao4Label[i][j] = "valorPainel1_botao4." + IntegerToString(i) + "." + IntegerToString(j);
        }
     }

//--- Legendas Botão 5
   valoresPainel3_botao5[0][0] = "V.  T.:";
   valoresPainel3_botao5[0][1] = StringFormat("%02.0f", quantidadeVitorias_total);
   valoresPainel3_botao5[1][0] = "D.  T.:";
   valoresPainel3_botao5[1][1] = StringFormat("%02.0f", quantidadeDerrotas_total);
   valoresPainel3_botao5[2][0] = "%  T.:";
   valoresPainel3_botao5[2][1] = StringFormat("%02.2f", assertividadeCombinada) + "%";

   for(int  i = 0; i < 3; i++)
     {
      for(int j = 0; j < 2; j++)
        {
         valoresPainel3_botao5Label[i][j] = "valoresPainel3_botao5." + IntegerToString(i) + "." + IntegerToString(j);
        }
     }

   if(velasPor_quadrante == 5)
     {
      PrepararMatriz_StringTres(18, valoresPainel1_botao5Label);
      for(int i = 0; i < 18; i++)
        {
         valoresPainel1_botao5Label[i][0] = "legendasPainel1_botao5Vertical.0." + IntegerToString(i);
         valoresPainel1_botao5Label[i][1] = "legendasPainel1_botao5Vertical.1." + IntegerToString(i);
         valoresPainel1_botao5Label[i][2] = "legendasPainel1_botao5Vertical.2." + IntegerToString(i);
        }
     }
   else
      if(velasPor_quadrante == 6)
        {
         PrepararMatriz_StringTres(22, valoresPainel1_botao5Label);
         for(int i = 0; i < 22; i++)
           {
            valoresPainel1_botao5Label[i][0] = "legendasPainel1_botao5Vertical.0." + IntegerToString(i);
            valoresPainel1_botao5Label[i][1] = "legendasPainel1_botao5Vertical.1." + IntegerToString(i);
            valoresPainel1_botao5Label[i][2] = "legendasPainel1_botao5Vertical.2." + IntegerToString(i);
           }
        }
      else
         if(velasPor_quadrante == 4)
           {
            PrepararMatriz_StringTres(14, valoresPainel1_botao5Label);
            for(int i = 0; i < 14; i++)
              {
               valoresPainel1_botao5Label[i][0] = "legendasPainel1_botao5Vertical.0." + IntegerToString(i);
               valoresPainel1_botao5Label[i][1] = "legendasPainel1_botao5Vertical.1." + IntegerToString(i);
               valoresPainel1_botao5Label[i][2] = "legendasPainel1_botao5Vertical.2." + IntegerToString(i);
              }
           }

//--- Legendas e Valores Botão 7
   PrepararVetor_String(2, legendasPainel1_botao7);
   legendasPainel1_botao7[0] = "RELATÓRIO GERADO EM: ";
   legendasPainel1_botao7[1] = TerminalInfoString(TERMINAL_DATA_PATH) + "/MQL5/Files";
   ArrayReverse(legendasPainel1_botao7);

   PrepararVetor_String(ArrayRange(legendasPainel1_botao7, 0), legendasPainel1_botao7Vertical_label);
   for(int i = 0; i < ArrayRange(legendasPainel1_botao7, 0); i++)
     {
      legendasPainel1_botao7Vertical_label[i]
         = "legendasPainel1_botao7." + IntegerToString(i);
     }

//--- Legendas e Valores Botão 8
   PrepararVetor_String(ArrayRange(legendasPainel1_botao8Vertical, 0), legendasPainel1_botao8Vertical_label);
   for(int i = 0; i < ArrayRange(legendasPainel1_botao8Vertical, 0); i++)
     {
      legendasPainel1_botao8Vertical_label[i]
         = "legendasPainel1_botao8." + IntegerToString(i);
     }

   PrepararVetor_String(11, valoresPainel1_botao8);
   valoresPainel1_botao8[0] = horarioInicio_concatenado;
   valoresPainel1_botao8[1] = IntegerToString(diaAnterior_inicio);
   valoresPainel1_botao8[2] = horarioOperacoes_concatenado;
   valoresPainel1_botao8[3] = horarioFim_concatenado;
   valoresPainel1_botao8[4] = IntegerToString(diaAnterior_fim);
   if(horarioNegociacao == true)
     {
      if(horarioAtual_estrutura.min == 00 || horarioAtual_estrutura.min == 10 || horarioAtual_estrutura.min == 20 ||
         horarioAtual_estrutura.min == 30 || horarioAtual_estrutura.min == 40 || horarioAtual_estrutura.min == 50)
        {
         valoresPainel1_botao8[5] = "DENTRO DO HOR. " + "(" + IntegerToString(horarioAtual_estrutura.hour) + ":" + IntegerToString(horarioAtual_estrutura.min) + ")";
        }
      else
         if(horarioAtual_estrutura.min == 1 || horarioAtual_estrutura.min == 10 || horarioAtual_estrutura.min == 2 ||
            horarioAtual_estrutura.min == 3 || horarioAtual_estrutura.min == 4 || horarioAtual_estrutura.min == 5 ||
            horarioAtual_estrutura.min == 6 || horarioAtual_estrutura.min == 7 || horarioAtual_estrutura.min == 8 ||
            horarioAtual_estrutura.min == 9)
           {
            valoresPainel1_botao8[5] = "DENTRO DO HOR. " + "(" + IntegerToString(horarioAtual_estrutura.hour) + ":0" + IntegerToString(horarioAtual_estrutura.min) + ")";
           }
         else
           {
            valoresPainel1_botao8[5] = "DENTRO DO HOR. " + "(" + IntegerToString(horarioAtual_estrutura.hour) + ":" + IntegerToString(horarioAtual_estrutura.min) + ")";
           }
     }
   else
     {
      if(horarioAtual_estrutura.min == 00 || horarioAtual_estrutura.min == 10 || horarioAtual_estrutura.min == 20 ||
         horarioAtual_estrutura.min == 30 || horarioAtual_estrutura.min == 40 || horarioAtual_estrutura.min == 50)
        {
         valoresPainel1_botao8[5] = "FORA  DO HOR. " + "(" + IntegerToString(horarioAtual_estrutura.hour) + ":" + IntegerToString(horarioAtual_estrutura.min) + ")";
        }
      else
         if(horarioAtual_estrutura.min == 1 || horarioAtual_estrutura.min == 10 || horarioAtual_estrutura.min == 2 ||
            horarioAtual_estrutura.min == 3 || horarioAtual_estrutura.min == 4 || horarioAtual_estrutura.min == 5 ||
            horarioAtual_estrutura.min == 6 || horarioAtual_estrutura.min == 7 || horarioAtual_estrutura.min == 8 ||
            horarioAtual_estrutura.min == 9)
           {
            valoresPainel1_botao8[5] = "FORA  DO HOR. " + "(" + IntegerToString(horarioAtual_estrutura.hour) + ":0" + IntegerToString(horarioAtual_estrutura.min) + ")";
           }
         else
           {
            valoresPainel1_botao8[5] = "FORA  DO HOR. " + "(" + IntegerToString(horarioAtual_estrutura.hour) + ":" + IntegerToString(horarioAtual_estrutura.min) + ")";
           }
     }

   valoresPainel1_botao8[6] = IntegerToString(katanaBarreira);
   valoresPainel1_botao8[7] = IntegerToString(posicoes);
   valoresPainel1_botao8[8] = "TRADER MODERADO";;
   valoresPainel1_botao8[9] = website;
   valoresPainel1_botao8[10] = nomeUsuario;
   ArrayReverse(valoresPainel1_botao8, 0, WHOLE_ARRAY);

   PrepararVetor_String(ArrayRange(valoresPainel1_botao8, 0), valoresPainel1_botao8Label);
   for(int i = 0; i < ArrayRange(valoresPainel1_botao8Label, 0); i++)
     {
      valoresPainel1_botao8Label[i]
         = "valorPainel1_botao8." + IntegerToString(i);
     }

//+------------------------------------------------------------------+
//| CONDIÇÕES DE BOTÃO PRESSIONADO (IN TIMER)                        |
//+------------------------------------------------------------------+
   if(mostrarPainel == true)
     {
      switch(botaoSelecionado)
        {
         case 1:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", tamanhoLinha * ArrayRange(legendasPainel1_botao1Vertical, 0) + 7, tamanhoLinha * ArrayRange(legendasPainel1_botao1Vertical, 0) + 3, false, 1);
            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
              }

            AjustarPosicao_X("Botao Inicio", 10000);
            AjustarPosicao_X("Botao Fim", 10000);
            AjustarPosicao_X("Fundo 3", 10000);

            for(int i = 0; i < ArrayRange(valoresPainel1_botao1Label, 0); i++)
              {
               CriarTexto_Painel(legendasPainel1_botao1Vertical_label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 2,
                                 deltaY + tamanhoLinha * i, legendasPainel1_botao1Vertical[i], "Arial Black", 10, clrBlack, 3);
               CriarTexto_Painel(valoresPainel1_botao1Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 21,
                                 deltaY + tamanhoLinha * i, valoresPainel1_botao1[i], "Arial Black", 10, clrBlack, 3);
              }
            break;
         case 2:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", deltaY * 43, deltaY * 43 - 3, false, 1);
            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), deltaX * 50);
              }

            AjustarPosicao_X("Botao Inicio", deltaX * 54 + 4);
            AjustarPosicao_X("Botao Fim", deltaX * 54 + 4);
            AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
            AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
            AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
            AjustarPosicao_X("Fundo 3", 10000);

            if(indiceFim_inicioEA_botao2 == false || parametrosAlterados == true)
              {
               FinalIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
               indiceFim_inicioEA_botao2 = true;
              }

            if(indiceMaximo_vetorAtual_botao2 > numeroLinhas)
              {
               indiceMaximo_vetorAtual_botao2 = numeroLinhas;
              }

            linhasGrafico_botao2 = 0;
            for(int i = indiceMinimo_vetorAtual_botao2; i < indiceMaximo_vetorAtual_botao2; i++)
              {
               CriarTexto_Painel(legendasPainel1_botao2Vertical_label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 2,
                                 deltaY * 43 - 59 - ((tamanhoLinha + 5) * linhasGrafico_botao2), legendasPainel1_botao2Vertical[i], "Arial Black", 10, clrBlack, 3);
               linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
              }

            if(velasPor_quadrante == 5)
              {
               for(int i = 0; i < 2; i++)
                 {
                  CriarTexto_Painel(legendasPainel1_botao2Horizontal_M1Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 20 + (deltaX * 14 - 4) * i,
                                    deltaY * 40, legendasPainel1_botao2Horizontal_M1[i], "Arial Black", 10, clrBlack, 1000);
                 }

               for(int i = 2; i < ArrayRange(legendasPainel1_botao2Horizontal_M1, 0); i++)
                 {
                  CriarTexto_Painel(legendasPainel1_botao2Horizontal_M1Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 185 + (deltaX * 5) * i,
                                    deltaY * 40, legendasPainel1_botao2Horizontal_M1[i], "Arial Black", 10, clrBlack, 1000);
                 }


               linhasGrafico_botao2 = 0;
               for(int i = linhasGrafico_botao2; i < 11; i++)
                 {
                  PosicionarImagem_Painel(quadrantePainel1_botao2Label[i], "::Images\\quadranteM1.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 3,
                                          deltaY * 37 - 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                  linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
                 }

               linhasGrafico_botao2 = 0;
               for(int i = indiceMinimo_vetorAtual_botao2; i < indiceMaximo_vetorAtual_botao2; i++)
                 {
                  for(int j = 0; j < 5; j++)
                    {
                     if(valoresPainel1_botao2M1[i][j] == "1")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Label_M1[i][j], "::Images\\velaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 10 + 19 * j,
                                                deltaY * 37 - 1 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(valoresPainel1_botao2M1[i][j] == "2")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Label_M1[i][j], "::Images\\velaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 10 + 19 * j,
                                                   deltaY * 37 - 1 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(valoresPainel1_botao2M1[i][j] == "0")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Label_M1[i][j], "::Images\\velaCinza.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 10 + 19 * j,
                                                      deltaY * 37 - 1 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                    }

                  if(maioriaVelas[i][1] == "1")
                    {
                     PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M1Label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 223 + (deltaX * 6),
                                             deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                    }
                  else
                     if(maioriaVelas[i][1] == "2")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M1Label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 223 + (deltaX * 6),
                                                deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaVelas[i][1] == "0")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M1Label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 223 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }

                  if(maioriaTres_primeiras[i][1] == "1")
                    {
                     PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM1_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 275 + (deltaX * 6),
                                             deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                    }
                  else
                     if(maioriaTres_primeiras[i][1] == "2")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM1_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 275 + (deltaX * 6),
                                                deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_primeiras[i][1] == "0")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM1_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 275 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }

                  if(maioriaTres_meio[i][1] == "1")
                    {
                     PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM1_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 328 + (deltaX * 6),
                                             deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                    }
                  else
                     if(maioriaTres_meio[i][1] == "2")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM1_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 328 + (deltaX * 6),
                                                deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_meio[i][1] == "0")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM1_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 328 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }

                  if(maioriaTres_ultimas[i][1] == "1")
                    {
                     PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM1_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 376 + (deltaX * 6),
                                             deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                    }
                  else
                     if(maioriaTres_ultimas[i][1] == "2")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM1_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 376 + (deltaX * 6),
                                                deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_ultimas[i][1] == "0")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM1_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 376 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                  linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
                 }
              }
            else
               if(velasPor_quadrante == 6)
                 {
                  for(int i = 0; i < 2; i++)
                    {
                     CriarTexto_Painel(legendasPainel1_botao2Horizontal_M5Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 20 + (deltaX * 14 + 5) * i,
                                       deltaY * 40, legendasPainel1_botao2Horizontal_M5[i], "Arial Black", 10, clrBlack, 1000);
                    }

                  for(int i = 2; i < ArrayRange(legendasPainel1_botao2Horizontal_M5, 0); i++)
                    {
                     CriarTexto_Painel(legendasPainel1_botao2Horizontal_M5Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 216 + (deltaX * 3 + 8) * i,
                                       deltaY * 40, legendasPainel1_botao2Horizontal_M5[i], "Arial Black", 10, clrBlack, 1000);
                    }

                  linhasGrafico_botao2 = 0;
                  for(int i = linhasGrafico_botao2; i < 11; i++)
                    {
                     PosicionarImagem_Painel(quadrantePainel1_botao2Label[i], "::Images\\quadranteM5.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 3,
                                             deltaY * 37 - 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                     linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
                    }

                  for(int i = indiceMinimo_vetorAtual_botao2; i < indiceMaximo_vetorAtual_botao2; i++)
                    {
                     for(int j = 0; j < 6; j++)
                       {
                        if(valoresPainel1_botao2M5[i][j] == "1")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Label_M5[i][j], "::Images\\velaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 10 + 19 * j,
                                                   deltaY * 75 + 4 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(valoresPainel1_botao2M5[i][j] == "2")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Label_M5[i][j], "::Images\\velaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 10 + 19 * j,
                                                      deltaY * 75 + 4 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                           else
                              if(valoresPainel1_botao2M5[i][j] == "0")
                                {
                                 PosicionarImagem_Painel(valoresPainel1_botao2Label_M5[i][j], "::Images\\velaCinza.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 10 + 19 * j,
                                                         deltaY * 75 + 4 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                                }
                       }

                     if(maioriaVelas[i][1] == "1")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M5Label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 229 + (deltaX * 6),
                                                deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaVelas[i][1] == "2")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M5Label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 229 + (deltaX * 6),
                                                   deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaVelas[i][1] == "0")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M5Label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 229 + (deltaX * 6),
                                                      deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }

                     if(maioriaTres_primeiras[i][1] == "1")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM5_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 270 + (deltaX * 6),
                                                deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_primeiras[i][1] == "2")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM5_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 270 + (deltaX * 6),
                                                   deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaTres_primeiras[i][1] == "0")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM5_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 270 + (deltaX * 6),
                                                      deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }

                     if(maioriaTres_meio[i][1] == "1")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM5_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 309 + (deltaX * 6),
                                                deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_meio[i][1] == "2")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM5_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 309 + (deltaX * 6),
                                                   deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaTres_meio[i][1] == "0")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM5_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 309 + (deltaX * 6),
                                                      deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }

                     if(maioriaTres_meioM5_alt[i][1] == "1")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM5_altLabel[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 348 + (deltaX * 6),
                                                deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_meioM5_alt[i][1] == "2")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM5_altLabel[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 348 + (deltaX * 6),
                                                   deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaTres_meioM5_alt[i][1] == "0")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3meioM5_altLabel[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 348 + (deltaX * 6),
                                                      deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }

                     if(maioriaTres_ultimas[i][1] == "1")
                       {
                        PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM5_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 387 + (deltaX * 6),
                                                deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                       }
                     else
                        if(maioriaTres_ultimas[i][1] == "2")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM5_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 387 + (deltaX * 6),
                                                   deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaTres_ultimas[i][1] == "0")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM5_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 387 + (deltaX * 6),
                                                      deltaY * 75 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                     linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
                    }

                 }
               else
                  if(velasPor_quadrante == 4)
                    {
                     for(int i = 0; i < 2; i++)
                       {
                        CriarTexto_Painel(legendasPainel1_botao2Horizontal_M15Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 20 + (deltaX * 14 - 3) * i,
                                          deltaY * 40, legendasPainel1_botao2Horizontal_M15[i], "Arial Black", 10, clrBlack, 1000);
                       }

                     for(int i = 2; i < ArrayRange(legendasPainel1_botao2Horizontal_M15, 0); i++)
                       {
                        CriarTexto_Painel(legendasPainel1_botao2Horizontal_M15Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 145 + (deltaX * 7) * i,
                                          deltaY * 40, legendasPainel1_botao2Horizontal_M15[i], "Arial Black", 10, clrBlack, 1000);
                       }

                     linhasGrafico_botao2 = 0;
                     for(int i = linhasGrafico_botao2; i < 11; i++)
                       {
                        PosicionarImagem_Painel(quadrantePainel1_botao2Label[i], "::Images\\quadranteM15.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 13,
                                                deltaY * 37 - 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                        linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
                       }

                     linhasGrafico_botao2 = 0;
                     for(int i = indiceMinimo_vetorAtual_botao2; i < indiceMaximo_vetorAtual_botao2; i++)
                       {
                        for(int j = 0; j < 4; j++)
                          {
                           if(valoresPainel1_botao2M15[i][j] == "1")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Label_M15[i][j], "::Images\\velaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 20 + 19 * j,
                                                      deltaY * 37 - 1 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                           else
                              if(valoresPainel1_botao2M15[i][j] == "2")
                                {
                                 PosicionarImagem_Painel(valoresPainel1_botao2Label_M15[i][j], "::Images\\velaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 20 + 19 * j,
                                                         deltaY * 37 - 1 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                                }
                              else
                                 if(valoresPainel1_botao2M15[i][j] == "0")
                                   {
                                    PosicionarImagem_Painel(valoresPainel1_botao2Label_M15[i][j], "::Images\\velaCinza.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 15 + 20 + 19 * j,
                                                            deltaY * 37 - 1 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                                   }
                          }

                        if(maioriaVelas[i][1] == "1")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M15Label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 222 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaVelas[i][1] == "2")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M15Label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 222 + (deltaX * 6),
                                                      deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                           else
                              if(maioriaVelas[i][1] == "0")
                                {
                                 PosicionarImagem_Painel(valoresPainel1_botao2MaioriaQ_M15Label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 222 + (deltaX * 6),
                                                         deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                                }

                        if(maioriaTres_primeiras[i][1] == "1")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM15_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 295 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaTres_primeiras[i][1] == "2")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM15_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 295 + (deltaX * 6),
                                                      deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                           else
                              if(maioriaTres_primeiras[i][1] == "0")
                                {
                                 PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3primeirasM15_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 295 + (deltaX * 6),
                                                         deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                                }

                        if(maioriaTres_ultimas[i][1] == "1")
                          {
                           PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM15_label[i], "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 366 + (deltaX * 6),
                                                   deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                          }
                        else
                           if(maioriaTres_ultimas[i][1] == "2")
                             {
                              PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM15_label[i], "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 366 + (deltaX * 6),
                                                      deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                             }
                           else
                              if(maioriaTres_ultimas[i][1] == "0")
                                {
                                 PosicionarImagem_Painel(valoresPainel1_botao2Maioria_3ultimasM15_label[i], "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 366 + (deltaX * 6),
                                                         deltaY * 36 + 5 - ((tamanhoLinha + 5) * linhasGrafico_botao2), 1000);
                                }
                        linhasGrafico_botao2 = linhasGrafico_botao2 + 1;
                       }
                    }

            //--- Atualização  Regular do Painel 1
            if(velasPor_quadrante == 5)
              {
               if((horarioAtual_estrutura.min == 00 || horarioAtual_estrutura.min == 05
                   || horarioAtual_estrutura.min == 10 || horarioAtual_estrutura.min == 15
                   || horarioAtual_estrutura.min == 20 || horarioAtual_estrutura.min == 25
                   || horarioAtual_estrutura.min == 30 || horarioAtual_estrutura.min == 35
                   || horarioAtual_estrutura.min == 40 || horarioAtual_estrutura.min == 45
                   || horarioAtual_estrutura.min == 50 || horarioAtual_estrutura.min == 55)
                  && horarioAtual_estrutura.sec == 00)
                 {
                  FinalIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                 }
              }
            else
               if(velasPor_quadrante == 6)
                 {
                  if((horarioAtual_estrutura. min == 00 || horarioAtual_estrutura.min == 30) &&
                     horarioAtual_estrutura.sec == 00)
                    {
                     FinalIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                    }
                 }
               else
                  if(velasPor_quadrante == 4)
                    {
                     if(horarioAtual_estrutura.min == 00 && horarioAtual_estrutura.sec == 00)
                       {
                        FinalIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                       }
                    }

            break;

         case 3:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", deltaY * 43, deltaY * 43 - 3, false, 1);
            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
              }

            AjustarPosicao_X("Botao Inicio", 10000);
            AjustarPosicao_X("Botao Fim", 10000);
            AjustarPosicao_X("Fundo 3", deltaX * 50);

            for(int  i = 0; i < 3; i++)
              {
               CriarTexto_Painel(valoresPainel3_botao3Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51,
                                 deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao3[i], "Arial Black", 10, clrBlack, 3);
              }

            AjustarPosicao_X(valoresPainel3_botao3Label[0], deltaX * 51 + 15);
            AjustarPosicao_X(valoresPainel3_botao3Label[2], deltaX * 51 + 25);

            for(int i = 0; i < ArrayRange(valoresPainel1_botao3Label, 0); i++)
              {
               if(tabelaFinal_ocorrencias[i][2] != "00/00 (0.00%)")
                 {
                  CriarTexto_Painel(valoresPainel1_botao3Label[i][0], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX + 5,
                                    deltaY * 41 - 5 - (19 * i), tabelaFinal_ocorrencias[i][0], "Arial Black", 10, clrBlack, 3);

                  CriarTexto_Painel(valoresPainel1_botao3Label[i][1], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 4 + 8,
                                    deltaY * 41 - 5 - (19 * i), tabelaFinal_ocorrencias[i][1], "Arial Black", 10, clrBlack, 3);

                  CriarTexto_Painel(valoresPainel1_botao3Label[i][2], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 30,
                                    deltaY * 41 - 5 - (19 * i), tabelaFinal_ocorrencias[i][2], "Arial Black", 10, clrBlack, 3);

                  if(tabelaFinal_ocorrencias[i][3] == "-")
                    {
                     CriarTexto_Painel(valoresPainel1_botao3Label[i][3], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 42,
                                       deltaY * 41 - 5 - (19 * i), tabelaFinal_ocorrencias[i][3], "Arial Black", 10, clrBlack, 3);
                    }
                  else
                    {
                     CriarTexto_Painel(valoresPainel1_botao3Label[i][3], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 42,
                                       deltaY * 41 - 5 - (19 * i), tabelaFinal_ocorrencias[i][3], "Arial Black", 10, clrRed, 3);
                    }
                 }
              }

            break;

         case 4:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", deltaY * 43, deltaY * 43 - 3, false, 1);

            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), deltaX * 50);
              }

            AjustarPosicao_X("Botao Inicio", deltaX * 54 + 4);
            AjustarPosicao_X("Botao Fim", deltaX * 54 + 4);
            AjustarPosicao_X("Fundo 3", 10000);

            if(indiceFim_inicioEA_botao4 == false || parametrosAlterados == true)
              {
               FinalIndices(ArrayRange(valoresPainel1_botao4Label, 0), diferencaIndice_botao4, indiceMaximo_vetorAtual_botao4, indiceMinimo_vetorAtual_botao4);
               indiceFim_inicioEA_botao4 = true;
              }

            if(indiceMaximo_vetorAtual_botao4 > ArrayRange(valoresPainel1_botao4Label, 0))
              {
               indiceMaximo_vetorAtual_botao4 = ArrayRange(valoresPainel1_botao4Label, 0);
              }

            CriarTexto_Painel(legendasPainel1_botao4Horizontal_label[0], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 18,
                              deltaY * 40, legendasPainel1_botao4Horizontal[0], "Arial Black", 10, clrBlack, 1000);

            for(int i = 1; i < 2; i++)
              {
               CriarTexto_Painel(legendasPainel1_botao4Horizontal_label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, (deltaX * 13 + 6) * i + 1,
                                 deltaY * 40, legendasPainel1_botao4Horizontal[i], "Arial Black", 10, clrBlack, 1000);
              }

            for(int i = 2; i < 3; i++)
              {
               CriarTexto_Painel(legendasPainel1_botao4Horizontal_label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, (deltaX * 14 + 4) * i - 1,
                                 deltaY * 40, legendasPainel1_botao4Horizontal[i], "Arial Black", 10, clrBlack, 1000);
              }

            CriarTexto_Painel(legendasPainel1_botao4Horizontal_label[3], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 28 + (deltaX * 37) -4,
                              deltaY * 40, legendasPainel1_botao4Horizontal[3], "Arial Black", 10, clrBlack, 1000);

            linhasGrafico_botao4 = 0;
            for(int i = indiceMinimo_vetorAtual_botao4; i < indiceMaximo_vetorAtual_botao4; i++)
              {
               for(int j = 0; j < 1; j++)
                 {
                  CriarTexto_Painel(valoresPainel1_botao4Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, 18,
                                    deltaY * 43 - 59 - ((tamanhoLinha + 5) * linhasGrafico_botao4), valoresPainel1_botao4[i][j], "Arial Black", 10, clrBlack, 3);
                 }

               for(int j = 1; j < 2; j++)
                 {
                  CriarTexto_Painel(valoresPainel1_botao4Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, (deltaX * 13) * j - 12,
                                    deltaY * 43 - 59 - ((tamanhoLinha + 5) * linhasGrafico_botao4), valoresPainel1_botao4[i][j], "Arial Black", 10, clrBlack, 3);
                 }

               for(int j = 2; j < 3; j++)
                 {
                  CriarTexto_Painel(valoresPainel1_botao4Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, (deltaX * 13) * j - 2,
                                    deltaY * 43 - 59 - ((tamanhoLinha + 5) * linhasGrafico_botao4), valoresPainel1_botao4[i][j], "Arial Black", 10, clrBlack, 3);
                 }

               for(int j = 3; j < 4; j++)
                 {
                  CriarTexto_Painel(valoresPainel1_botao4Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, (deltaX * 13 + 5) * j - 1,
                                    deltaY * 43 - 59 - ((tamanhoLinha + 5) * linhasGrafico_botao4), valoresPainel1_botao4[i][j], "Arial Black", 10, clrBlack, 3);
                 }

               linhasGrafico_botao4 = linhasGrafico_botao4 + 1;
              }

            break;

         case 5:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", deltaY * 43, deltaY * 43 - 3, false, 1);
            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
              }

            AjustarPosicao_X("Botao Inicio", 10000);
            AjustarPosicao_X("Botao Fim", 10000);
            AjustarPosicao_X("Fundo 3", deltaX * 50);

            for(int  i = 0; i < 1; i++)
              {
               for(int j = 0; j < 2; j++)
                 {
                  CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                    deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao5[i][j], "Arial Black", 10, clrBlack, 3);
                 }
              }

            for(int  i = 1; i < 2; i++)
              {
               for(int j = 0; j < 1; j++)
                 {
                  CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                    deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao5[i][j], "Arial Black", 10, clrBlack, 3);
                 }

               for(int j = 1; j < 2; j++)
                 {
                  if(StringToInteger(valoresPainel3_botao5[i][j]) < 0)
                    {
                     CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                       deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), StringFormat("%02.0f", (StringToInteger(valoresPainel3_botao5[i][j]) * -1)), "Arial Black", 10, clrBlack, 3);
                    }
                  else
                    {
                     CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                       deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao5[i][j], "Arial Black", 10, clrBlack, 3);

                    }
                 }
              }

            for(int  i = 2; i < 3; i++)
              {
               for(int j = 0; j < 1; j++)
                 {
                  CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                    deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao5[i][j], "Arial Black", 10, clrBlack, 3);
                 }
               for(int j = 1; j < 2; j++)
                 {
                  if(StringToDouble(valoresPainel3_botao5[i][j]) < 0)
                    {
                     CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                       deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao5[i][j], "Arial Black", 10, clrRed, 3);
                    }
                  else
                    {
                     CriarTexto_Painel(valoresPainel3_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 51 + (j * 45),
                                       deltaY * 41 - 5 - ((tamanhoLinha - 10) * i), valoresPainel3_botao5[i][j], "Arial Black", 10, clrBlack, 3);
                    }
                 }
              }

            for(int i = 0; i < ArrayRange(valoresPainel1_botao5Label, 0); i++)
              {
               for(int j = 0; j < 1; j++)
                 {
                  CriarTexto_Painel(valoresPainel1_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 2,
                                    deltaY * 41 - 5 - (19 * i), tabelaFinal_assertividade[i][j], "Arial Black", 10, clrBlack, 3);
                 }
               for(int j = 1; j < 2; j++)
                 {
                  CriarTexto_Painel(valoresPainel1_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 7 * j,
                                    deltaY * 41 - 5 - (19 * i), tabelaFinal_assertividade[i][j], "Arial Black", 10, clrBlack, 3);
                 }
               for(int j = 2; j < 3; j++)
                 {
                  if(StringFind(tabelaFinal_assertividade[i][j], "(-", 0) != -1)
                    {
                     CriarTexto_Painel(valoresPainel1_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 16 * j + 5,
                                       deltaY * 41 - 5 - (19 * i), tabelaFinal_assertividade[i][j], "Arial Black", 10, clrRed, 3);
                    }
                  else
                    {
                     CriarTexto_Painel(valoresPainel1_botao5Label[i][j], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 16 * j + 5,
                                       deltaY * 41 - 5 - (19 * i), tabelaFinal_assertividade[i][j], "Arial Black", 10, clrBlack, 3);
                    }
                 }
              }
            break;

         case 6:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            if(horarioLocal_estrutura.sec % 2 == 0 && confirmacaoTestes == true)
              {
               Print("diaAnterior_inicioVar: ", diaAnterior_inicioVar);
               Print("diaAnterior_fimVar: ", diaAnterior_fimVar);
               diaAnterior_inicioVar += 1;
               diaAnterior_fimVar += 1;
              }

            if(confirmacaoTestes == true && diaAnterior_inicioVar == diasTeste + diaAnterior_inicio + 1)
              {
               Print("terminou o teste!");
               confirmacaoTestes = false;
              }

            break;

         case 7:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", deltaY * ArrayRange(legendasPainel1_botao7, 0) * 2 + 20, tamanhoLinha * ArrayRange(legendasPainel1_botao7, 0) - 3, false, 1);

            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
              }

            AjustarPosicao_X("Botao Inicio", 10000);
            AjustarPosicao_X("Botao Fim", 10000);
            AjustarPosicao_X("Fundo 3", 10000);

            CriarTexto_Painel(legendasPainel1_botao7Vertical_label[0], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 2,
                              deltaY + tamanhoLinha * 0, legendasPainel1_botao7[0], "Arial", 10, clrRed, 3);
            CriarTexto_Painel(legendasPainel1_botao7Vertical_label[1], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 2,
                              deltaY + tamanhoLinha * 1 - 7, legendasPainel1_botao7[1], "Arial Black", 10, clrBlack, 3);

            if(velasPor_quadrante == 5)
              {
               tempoVelas = "M1";
              }
            else
               if(velasPor_quadrante == 6)
                 {
                  tempoVelas = "M5";
                 }
               else
                  if(velasPor_quadrante == 4)
                    {
                     tempoVelas = "M15";
                    }
            break;

         case 8:
            ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                               legendasPainel1_botao2Vertical_label,
                               legendasPainel1_botao7Vertical_label,
                               legendasPainel1_botao8Vertical_label,
                               legendasPainel1_botao2Horizontal_M1Label,
                               legendasPainel1_botao2Horizontal_M5Label,
                               legendasPainel1_botao2Horizontal_M15Label,
                               legendasPainel1_botao4Horizontal,
                               legendasPainel1_botao4Horizontal_label,
                               legendasPainel2_entradaLabel,
                               legendasPainel2_quadranteAtual_M1Label,
                               legendasPainel2_quadranteAtual_M5Label,
                               legendasPainel2_quadranteAtual_M15Label,
                               valoresPainel1_botao1Label,
                               quadrantePainel1_botao2Label,
                               valoresPainel1_botao2Label_M1,
                               valoresPainel1_botao2Label_M5,
                               valoresPainel1_botao2Label_M15,
                               valoresPainel1_botao2MaioriaQ_M1Label,
                               valoresPainel1_botao2MaioriaQ_M5Label,
                               valoresPainel1_botao2MaioriaQ_M15Label,
                               valoresPainel1_botao2Maioria_3primeirasM1_label,
                               valoresPainel1_botao2Maioria_3primeirasM5_label,
                               valoresPainel1_botao2Maioria_3primeirasM15_label,
                               valoresPainel1_botao2Maioria_3meioM1_label,
                               valoresPainel1_botao2Maioria_3meioM5_label,
                               valoresPainel1_botao2Maioria_3meioM5_altLabel,
                               valoresPainel1_botao2Maioria_3ultimasM1_label,
                               valoresPainel1_botao2Maioria_3ultimasM5_label,
                               valoresPainel1_botao2Maioria_3ultimasM15_label,
                               valoresPainel1_botao3Label,
                               valoresPainel1_botao4Label,
                               valoresPainel1_botao5Label,
                               valoresPainel1_botao8Label,
                               valoresPainel2_entradaLabel,
                               valoresPainel2_quadranteAtual_label,
                               valoresPainel3_botao3Label,
                               valoresPainel3_botao5Label);

            AjustarAltura_Painel("Fundo 1", tamanhoLinha * ArrayRange(legendasPainel1_botao8Vertical, 0) + 5, tamanhoLinha * ArrayRange(legendasPainel1_botao8Vertical, 0) +2, false, 0);

            for(int i = 1; i <= 2; i++)
              {
               AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
              }

            AjustarPosicao_X("Botao Inicio", 10000);
            AjustarPosicao_X("Botao Fim", 10000);
            AjustarPosicao_X("Fundo 3", 10000);

            for(int i = 0; i < 11; i++)
              {
               CriarTexto_Painel(legendasPainel1_botao8Vertical_label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 2,
                                 deltaY + tamanhoLinha * i, legendasPainel1_botao8Vertical[i], "Arial Black", 10, clrBlack, 10);
               CriarTexto_Painel(valoresPainel1_botao8Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 27,
                                 deltaY + tamanhoLinha * i, valoresPainel1_botao8[i], "Arial Black", 10, clrBlack, 10);
              }
            break;
        }
     }

//+------------------------------------------------------------------+
//| PAINEL 2                                                         |
//+------------------------------------------------------------------+
//--- Quadrante Atual
   if(velasPor_quadrante == 5)
     {
      for(int i = 0; i < ArrayRange(legendasPainel2_quadranteAtual_M1Label, 0); i++)
        {
         legendasPainel2_quadranteAtual_M1Label[i] = "legendasPainel2_quadranteAtual_M1." + IntegerToString(i);
        }

      if(mostrarPainel == true)
        {
         for(int i = 0; i < 2; i++)
           {
            CriarTexto_Painel(legendasPainel2_quadranteAtual_M1Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65 + 14 * deltaX * i,
                              deltaY * 17, legendasPainel2_quadranteAtual_M1[i], "Arial Black", 10, clrBlack, 2000);
           }
         for(int i = 2; i < ArrayRange(legendasPainel2_quadranteAtual_M1Label, 0); i++)
           {
            CriarTexto_Painel(legendasPainel2_quadranteAtual_M1Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 85 + 5 * deltaX * i,
                              deltaY * 17, legendasPainel2_quadranteAtual_M1[i], "Arial Black", 10, clrBlack, 2000);
           }

         if(quadranteComplementar_qualquerVela == true)
           {
            CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                              deltaY * 13 + 5, TimeToString(dadosVelas_quadranteComplementar[0].time), "Arial Black", 10, clrBlack, 2000);
           }
         else
            if(horarioNegociacao == true)
              {
               CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                                 deltaY * 13 + 5, TimeToString(dadosVelas_quadranteAtual[0].time), "Arial Black", 10, clrBlack, 2000);
              }
            else
              {
               CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                                 deltaY * 13 + 5, TimeToString(TimeCurrent()), "Arial Black", 10, clrBlack, 2000);
              }

         PosicionarImagem_Painel("quadranteAtual_Painel2", "::Images\\quadranteM1.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 80 + 5,
                                 deltaY * 13, 2000);

         PrepararVetor_String(ArrayRange(quadranteAcrescimo_definitivo, 0), valoresPainel2_quadranteAtual_label);
         for(int i = 0; i < ArrayRange(quadranteAcrescimo_definitivo, 0); i++)
           {
            valoresPainel2_quadranteAtual_label[i] = "valoresPainel2_quadranteAtual" + IntegerToString(i);

            if((velaAtual > 0 && velaAtual <= 3) || velaComplementar >= 1)
              {
               if(quadranteAcrescimo_definitivo[i] == 1)
                 {
                  PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 81 + 2 + 19 * i,
                                          deltaY * 13 + 4, 1000);
                 }
               else
                  if(quadranteAcrescimo_definitivo[i] == 2)
                    {
                     PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 81 + 2 + 19 * i,
                                             deltaY * 13 + 4, 1000);
                    }
                  else
                     if(quadranteAcrescimo_definitivo[i] == 0)
                       {
                        PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaCinza.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 81 + 2 + 19 * i,
                                                deltaY * 13 + 4, 1000);
                       }
              }
           }

         if((maioriaVelas_quadranteAtual == 1 || maioriaVelas_quadranteComplementar == 1) && (velaAtual >= 1 || velaComplementar >= 1))
           {
            PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 94 + 8,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaVelas_quadranteAtual == 2 || maioriaVelas_quadranteComplementar == 2) && (velaAtual >= 1 || velaComplementar >= 1))
              {
               PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 94 + 8,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria QA");
               PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 94 + 8,
                                       deltaY * 13, 1000);
              }

         if((maioriaTres_primeirasQuadrante_atual == 1 || maioriaTres_primeirasQuadrante_complementar == 1) && (velaAtual >= 2 || velaComplementar >= 2))
           {
            PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 100 + 1,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaTres_primeirasQuadrante_atual == 2 || maioriaTres_primeirasQuadrante_complementar == 2) && (velaAtual >= 2 || velaComplementar >= 2))
              {
               PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 100 + 1,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria 3PQA");
               PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 100 + 1,
                                       deltaY * 13, 1000);
              }

         if((maioriaTres_meioQuadrante_atual == 1 || maioriaTres_meioQuadrante_complementar == 1) && (velaAtual >= 3 || velaComplementar >= 3))
           {
            PosicionarImagem_Painel("Maioria 3MQA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 105 + 3,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaTres_meioQuadrante_atual == 2 || maioriaTres_meioQuadrante_complementar == 2) && (velaAtual >= 3 || velaComplementar >= 3))
              {
               PosicionarImagem_Painel("Maioria 3MQA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 105 + 3,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria 3MQA");
               PosicionarImagem_Painel("Maioria 3MQA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 105 + 3,
                                       deltaY * 13, 1000);
              }
        }
      else
        {
         for(int i = 0; i < ArrayRange(legendasPainel2_quadranteAtual_M1Label, 0); i++)
           {
            AjustarPosicao_X(legendasPainel2_quadranteAtual_M1Label[i], 10000);
           }
         AjustarPosicao_X("horarioQuadrante_atualPainel2", 10000);
         AjustarPosicao_X("quadranteAtual_Painel2", 10000);
         AjustarPosicao_X("Maioria QA", 10000);
         AjustarPosicao_X("Maioria 3PQA", 10000);
         AjustarPosicao_X("Maioria 3MQA", 10000);
        }
     }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(velasPor_quadrante == 6)
     {
      for(int i = 0; i < ArrayRange(legendasPainel2_quadranteAtual_M5Label, 0); i++)
        {
         legendasPainel2_quadranteAtual_M5Label[i] = "legendasPainel2_quadranteAtual_M5." + IntegerToString(i);
        }

      if(mostrarPainel == true)
        {
         for(int i = 0; i < 2; i++)
           {
            CriarTexto_Painel(legendasPainel2_quadranteAtual_M5Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65 + 14 * deltaX * i,
                              deltaY * 17, legendasPainel2_quadranteAtual_M5[i], "Arial Black", 10, clrBlack, 2000);
           }

         for(int i = 2; i < ArrayRange(legendasPainel2_quadranteAtual_M5Label, 0); i++)
           {
            CriarTexto_Painel(legendasPainel2_quadranteAtual_M5Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 86 + 4 * deltaX * i,
                              deltaY * 17, legendasPainel2_quadranteAtual_M5[i], "Arial Black", 10, clrBlack, 2000);

           }

         if(quadranteComplementar_qualquerVela == true)
           {
            CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                              deltaY * 13 + 5, TimeToString(dadosVelas_quadranteComplementar[0].time), "Arial Black", 10, clrBlack, 2000);
           }
         else
            if(horarioNegociacao == true)
              {
               CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                                 deltaY * 13 + 5, TimeToString(dadosVelas_quadranteAtual[0].time), "Arial Black", 10, clrBlack, 2000);
              }
            else
              {
               CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                                 deltaY * 13 + 5, TimeToString(TimeCurrent()), "Arial Black", 10, clrBlack, 2000);
              }


         PosicionarImagem_Painel("quadranteAtual_Painel2", "::Images\\quadranteM5.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 79 + 5,
                                 deltaY * 13, 2000);


         PrepararVetor_String(ArrayRange(quadranteAcrescimo_definitivo, 0), valoresPainel2_quadranteAtual_label);
         for(int i = 0; i < ArrayRange(quadranteAcrescimo_definitivo, 0); i++)
           {
            valoresPainel2_quadranteAtual_label[i] = "valoresPainel2_quadranteAtual" + IntegerToString(i);

            if((velaAtual > 0 && velaAtual <= 5) || velaComplementar >= 1)
              {
               if(quadranteAcrescimo_definitivo[i] == 1)
                 {
                  PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 80 + 2 + 19 * i,
                                          deltaY * 13 + 4, 1000);
                 }
               else
                  if(quadranteAcrescimo_definitivo[i] == 2)
                    {
                     PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 80 + 2 + 19 * i,
                                             deltaY * 13 + 4, 1000);
                    }
                  else
                     if(quadranteAcrescimo_definitivo[i] == 0)
                       {
                        PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaCinza.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 80 + 2 + 19 * i,
                                                deltaY * 13 + 4, 1000);
                       }
              }
           }

         if((maioriaVelas_quadranteAtual == 1 || maioriaVelas_quadranteComplementar == 1) && (velaAtual >= 1 || velaComplementar >= 1))
           {
            PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 93 + 8,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaVelas_quadranteAtual == 2 || maioriaVelas_quadranteComplementar == 2) && (velaAtual >= 1 || velaComplementar >= 1))
              {
               PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 93 + 8,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria QA");
               PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 93 + 8,
                                       deltaY * 13, 1000);
              }

         if((maioriaTres_primeirasQuadrante_atual == 1 || maioriaTres_primeirasQuadrante_complementar == 1) && (velaAtual >= 2 || velaComplementar >= 2))
           {
            PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 98,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaTres_primeirasQuadrante_atual == 2 || maioriaTres_primeirasQuadrante_complementar == 2) && (velaAtual >= 2 || velaComplementar >= 2))
              {
               PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 98,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria 3PQA");
               PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 98,
                                       deltaY * 13, 1000);
              }

         if((maioriaTres_meioQuadrante_atual == 1 || maioriaTres_meioQuadrante_complementar == 1) && (velaAtual >= 3 || velaComplementar >= 3))
           {
            PosicionarImagem_Painel("Maioria 3MQA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 102 + 2,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaTres_meioQuadrante_atual == 2 || maioriaTres_meioQuadrante_complementar == 2) && (velaAtual >= 3 || velaComplementar >= 3))
              {
               PosicionarImagem_Painel("Maioria 3MQA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 102 + 2,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria 3MQA");
               PosicionarImagem_Painel("Maioria 3MQA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 102 + 2,
                                       deltaY * 13, 1000);
              }

         if((maioriaTres_meioM5_altQuadrante_atual == 1 || maioriaTres_meioM5_altQuadrante_complementar == 1) && (velaAtual >= 4 || velaComplementar >= 4))
           {
            PosicionarImagem_Painel("Maioria 3M2QA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 106 + 4,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaTres_meioM5_altQuadrante_atual == 2 || maioriaTres_meioM5_altQuadrante_complementar == 2) && (velaAtual >= 4 || velaComplementar >= 4))
              {
               PosicionarImagem_Painel("Maioria 3M2QA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 106 + 4,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria 3M2QA");
               PosicionarImagem_Painel("Maioria 3M2QA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 106 + 4,
                                       deltaY * 13, 1000);
              }
        }
      else
        {
         for(int i = 0; i < ArrayRange(legendasPainel2_quadranteAtual_M1Label, 0); i++)
           {
            AjustarPosicao_X(legendasPainel2_quadranteAtual_M1Label[i], 10000);
           }
         AjustarPosicao_X("horarioQuadrante_atualPainel2", 10000);
         AjustarPosicao_X("quadranteAtual_Painel2", 10000);
         AjustarPosicao_X("Maioria QA", 10000);
         AjustarPosicao_X("Maioria 3PQA", 10000);
         AjustarPosicao_X("Maioria 3MQA", 10000);
         AjustarPosicao_X("Maioria 3M2QA", 10000);
        }
     }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(velasPor_quadrante == 4)
     {
      for(int i = 0; i < ArrayRange(legendasPainel2_quadranteAtual_M15Label, 0); i++)
        {
         legendasPainel2_quadranteAtual_M15Label[i] = "legendasPainel2_quadranteAtual_M15." + IntegerToString(i);
        }

      if(mostrarPainel == true)
        {
         for(int i = 0; i < 2; i++)
           {
            CriarTexto_Painel(legendasPainel2_quadranteAtual_M15Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65 + 14 * deltaX * i,
                              deltaY * 17, legendasPainel2_quadranteAtual_M15[i], "Arial Black", 10, clrBlack, 2000);
           }

         for(int i = 2; i < ArrayRange(legendasPainel2_quadranteAtual_M15Label, 0); i++)
           {
            CriarTexto_Painel(legendasPainel2_quadranteAtual_M15Label[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 83 + 7 * deltaX * i,
                              deltaY * 17, legendasPainel2_quadranteAtual_M15[i], "Arial Black", 10, clrBlack, 2000);

           }

         if(quadranteComplementar_qualquerVela == true)
           {
            CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                              deltaY * 13 + 5, TimeToString(dadosVelas_quadranteComplementar[0].time), "Arial Black", 10, clrBlack, 2000);
           }
         else
            if(horarioNegociacao == true)
              {
               CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                                 deltaY * 13 + 5, TimeToString(dadosVelas_quadranteAtual[0].time), "Arial Black", 10, clrBlack, 2000);
              }
            else
              {
               CriarTexto_Painel("horarioQuadrante_atualPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65,
                                 deltaY * 13 + 5, TimeToString(TimeCurrent()), "Arial Black", 10, clrBlack, 2000);
              }


         PosicionarImagem_Painel("quadranteAtual_Painel2", "::Images\\quadranteM15.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 81 + 5,
                                 deltaY * 13, 2000);


         PrepararVetor_String(ArrayRange(quadranteAcrescimo_definitivo, 0), valoresPainel2_quadranteAtual_label);
         for(int i = 0; i < ArrayRange(quadranteAcrescimo_definitivo, 0); i++)
           {
            valoresPainel2_quadranteAtual_label[i] = "valoresPainel2_quadranteAtual" + IntegerToString(i);

            if((velaAtual > 0 && velaAtual <= 3) || velaComplementar >= 1)
              {
               if(quadranteAcrescimo_definitivo[i] == 1)
                 {
                  PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 82 + 2 + 19 * i,
                                          deltaY * 13 + 4, 1000);
                 }
               else
                  if(quadranteAcrescimo_definitivo[i] == 2)
                    {
                     PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 82 + 2 + 19 * i,
                                             deltaY * 13 + 4, 1000);
                    }
                  else
                     if(quadranteAcrescimo_definitivo[i] == 0)
                       {
                        PosicionarImagem_Painel(valoresPainel2_quadranteAtual_label[i], "::Images\\velaCinza.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 82 + 2 + 19 * i,
                                                deltaY * 13 + 4, 1000);
                       }
              }
           }

         if((maioriaVelas_quadranteAtual == 1 || maioriaVelas_quadranteComplementar == 1) && (velaAtual >= 1 || velaComplementar >= 1))
           {
            PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 96 + 8,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaVelas_quadranteAtual == 2 || maioriaVelas_quadranteComplementar == 2) && (velaAtual >= 1 || velaComplementar >= 1))
              {
               PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 96 + 8,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria QA");
               PosicionarImagem_Painel("Maioria QA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 96 + 8,
                                       deltaY * 13, 1000);
              }

         if((maioriaTres_primeirasQuadrante_atual == 1 || maioriaTres_primeirasQuadrante_complementar == 1) && (velaAtual >= 2 || velaComplementar >= 2))
           {
            PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaVerde.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 104 + 1,
                                    deltaY * 13, 1000);
           }
         else
            if((maioriaTres_primeirasQuadrante_atual == 2 || maioriaTres_primeirasQuadrante_complementar == 2) && (velaAtual >= 2 || velaComplementar >= 2))
              {
               PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaVermelha.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 104 + 1,
                                       deltaY * 13, 1000);
              }
            else
              {
               ObjectDelete(0, "Maioria 3PQA");
               PosicionarImagem_Painel("Maioria 3PQA", "::Images\\maioriaSem.bmp", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 104 + 1,
                                       deltaY * 13, 1000);
              }
        }
      else
        {
         for(int i = 0; i < ArrayRange(legendasPainel2_quadranteAtual_M1Label, 0); i++)
           {
            AjustarPosicao_X(legendasPainel2_quadranteAtual_M1Label[i], 10000);
           }
         AjustarPosicao_X("horarioQuadrante_atualPainel2", 10000);
         AjustarPosicao_X("quadranteAtual_Painel2", 10000);
         AjustarPosicao_X("Maioria QA", 10000);
         AjustarPosicao_X("Maioria 3PQA", 10000);
        }
     }

//--- Seção de Entrada
   valoresPainel2[2] = tabelaEntrada[indiceEntrada][1];
   valoresPainel2[1] = tabelaEntrada[indiceEntrada][2];
   valoresPainel2[0] = tabelaEntrada[indiceEntrada][0];

   ultimaEntrada = tabelaEntrada[indiceEntrada][1];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(tabelaEntrada[indiceEntrada][3] != "AGUARDE" &&
      (TimeCurrent() >= horarioOperacoes_formatado - decrescimoSegundos_quadrante &&
       TimeCurrent() <= horarioFim_formatado + decrescimoSegundos_quadrante) &&
      ((velasPor_quadrante == 5 && horarioAtual_estrutura.sec == 1) ||
       (velasPor_quadrante == 6 && MathMod(horarioAtual_estrutura.min, 5) == 0 && horarioAtual_estrutura.sec == 1) ||
       (velasPor_quadrante == 4 && MathMod(horarioAtual_estrutura.min, 15) == 0 && horarioAtual_estrutura.sec == 1)))
     {
      Alert(Symbol(), "   ", tabelaEntrada[indiceEntrada][3], "!!   ", tabelaEntrada[indiceEntrada][1]);
     }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(mostrarPainel == true)
     {
      for(int i = 0; i < ArrayRange(legendasPainel2, 0); i++)
        {
         legendasPainel2_entradaLabel[i] = "legendasPainel2." + IntegerToString(i);
         CriarTexto_Painel(legendasPainel2_entradaLabel[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 74,
                           deltaY + 3 + (tamanhoLinha + 2) * i, legendasPainel2[i], "Arial Black", 10, clrBlack, 10);
        }

      if((horarioAtual_estrutura.hour == ajusteFino_horarioEstrutura.hour && horarioAtual_estrutura.min >= minutoFim) ||
         (horarioAtual_estrutura.hour == horaFim && horarioAtual_estrutura.min <= horaFim) ||
         (horarioAtual_estrutura.hour > ajusteFino_horarioEstrutura.hour && horarioAtual_estrutura.hour < horaFim))
        {
         for(int i = 0; i < ArrayRange(valoresPainel2, 0); i++)
           {
            valoresPainel2_entradaLabel[i] = "valoresPainel2." + IntegerToString(i);
            CriarTexto_Painel(valoresPainel2_entradaLabel[i], CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 89,
                              deltaY + 3 + (tamanhoLinha + 2) * i, valoresPainel2[i], "Arial Black", 10, clrBlack, 10);
           }

         if(tabelaEntrada[indiceEntrada][3] == "AGUARDE")
           {
            CriarTexto_Painel("statusPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65 + 3,
                              deltaY * 10 + 3, tabelaEntrada[indiceEntrada][3], "Arial Black", 10, clrBlack, 10);

            AjustarPosicao_X("Meditando", deltaX * 64 + 5);
            AjustarPosicao_X("Katana", 10000);

           }
         else
            if(tabelaEntrada[indiceEntrada][3] == "KATANÁ!")
              {
               CriarTexto_Painel("statusPainel2", CORNER_LEFT_LOWER, ANCHOR_LEFT_LOWER, deltaX * 65 + 3,
                                 deltaY * 10 + 3, tabelaEntrada[indiceEntrada][3], "Arial Black", 10, clrRed, 10);
               AjustarPosicao_X("Meditando", 10000);
               AjustarPosicao_X("Katana", deltaX * 64 + 5);
              }
        }
     }

   parametrosAlterados = false;
  }

//+------------------------------------------------------------------+
//| ON CHART EVENT (FUNÇÃO DE EVENTO NO GRÁFICO)                     |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   if(id == CHARTEVENT_CHART_CHANGE)
     {
      parametrosAlterados = true;
     }

   if(id == CHARTEVENT_OBJECT_CLICK)
     {
      if(sparam == "Botão 1")
        {
         botaoSelecionado = 1;
         PressionarBotao("Botão 1", "Botão 2", "Botão 3", "Botão 4", "Botão 5", "Botão 6", "Botão 7", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

         AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
         AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
         AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
         AjustarPosicao_X("Botão 10", 10000);
         AjustarPosicao_X("Botão 11", 10000);
        }
      else
         if(sparam == "Botão 2")
           {
            botaoSelecionado = 2;
            PressionarBotao("Botão 2", "Botão 1", "Botão 3", "Botão 4", "Botão 5", "Botão 6", "Botão 7", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

            AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
            AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
            AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
            AjustarPosicao_X("Botão 10", 10000);
            AjustarPosicao_X("Botão 11", 10000);
           }
         else
            if(sparam == "Botão 3")
              {
               botaoSelecionado = 3;
               PressionarBotao("Botão 3", "Botão 2", "Botão 1", "Botão 4", "Botão 5", "Botão 6", "Botão 7", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

               AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
               AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
               AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
               AjustarPosicao_X("Botão 10", 10000);
               AjustarPosicao_X("Botão 11", 10000);
              }
            else
               if(sparam == "Botão 4")
                 {
                  botaoSelecionado = 4;
                  PressionarBotao("Botão 4", "Botão 2", "Botão 1", "Botão 3", "Botão 5", "Botão 6", "Botão 7", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

                  AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                  AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                  AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                  AjustarPosicao_X("Botão 10", 10000);
                  AjustarPosicao_X("Botão 11", 10000);
                 }
               else
                  if(sparam == "Botão 5")
                    {
                     botaoSelecionado = 5;
                     PressionarBotao("Botão 5", "Botão 2", "Botão 3", "Botão 1", "Botão 4", "Botão 6", "Botão 7", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

                     AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                     AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                     AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                     AjustarPosicao_X("Botão 10", 10000);
                     AjustarPosicao_X("Botão 11", 10000);
                    }
                  else
                     if(sparam == "Botão 6")
                       {
                        mostrarPainel = false;

                        PressionarBotao("Botão 6", "Botão 2", "Botão 1", "Botão 3", "Botão 5", "Botão 4", "Botão 7", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

                        ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                                           legendasPainel1_botao2Vertical_label,
                                           legendasPainel1_botao7Vertical_label,
                                           legendasPainel1_botao8Vertical_label,
                                           legendasPainel1_botao2Horizontal_M1Label,
                                           legendasPainel1_botao2Horizontal_M5Label,
                                           legendasPainel1_botao2Horizontal_M15Label,
                                           legendasPainel1_botao4Horizontal,
                                           legendasPainel1_botao4Horizontal_label,
                                           legendasPainel2_entradaLabel,
                                           legendasPainel2_quadranteAtual_M1Label,
                                           legendasPainel2_quadranteAtual_M5Label,
                                           legendasPainel2_quadranteAtual_M15Label,
                                           valoresPainel1_botao1Label,
                                           quadrantePainel1_botao2Label,
                                           valoresPainel1_botao2Label_M1,
                                           valoresPainel1_botao2Label_M5,
                                           valoresPainel1_botao2Label_M15,
                                           valoresPainel1_botao2MaioriaQ_M1Label,
                                           valoresPainel1_botao2MaioriaQ_M5Label,
                                           valoresPainel1_botao2MaioriaQ_M15Label,
                                           valoresPainel1_botao2Maioria_3primeirasM1_label,
                                           valoresPainel1_botao2Maioria_3primeirasM5_label,
                                           valoresPainel1_botao2Maioria_3primeirasM15_label,
                                           valoresPainel1_botao2Maioria_3meioM1_label,
                                           valoresPainel1_botao2Maioria_3meioM5_label,
                                           valoresPainel1_botao2Maioria_3meioM5_altLabel,
                                           valoresPainel1_botao2Maioria_3ultimasM1_label,
                                           valoresPainel1_botao2Maioria_3ultimasM5_label,
                                           valoresPainel1_botao2Maioria_3ultimasM15_label,
                                           valoresPainel1_botao3Label,
                                           valoresPainel1_botao4Label,
                                           valoresPainel1_botao5Label,
                                           valoresPainel1_botao8Label,
                                           valoresPainel2_entradaLabel,
                                           valoresPainel2_quadranteAtual_label,
                                           valoresPainel3_botao3Label,
                                           valoresPainel3_botao5Label);

                        for(int i = 1; i <= 2; i++)
                          {
                           AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
                          }
                        AjustarPosicao_X("Fundo 1", 10000);
                        AjustarPosicao_X("Fundo 2", 10000);
                        AjustarPosicao_X("Fundo 3", deltaX * 50);
                        AjustarPosicao_Y("Fundo 3", deltaY * 31 + 3);
                        AjustarPosicao_X("Botao Inicio", 10000);
                        AjustarPosicao_X("Botao Fim", 10000);
                        AjustarPosicao_X("Logo Samurai", 10000);
                        AjustarPosicao_X("Logo Titulo", 10000);
                        AjustarPosicao_X("Logo TM", 10000);
                        AjustarPosicao_X("Meditando", 10000);
                        AjustarPosicao_X("Botão 1", 10000);
                        AjustarPosicao_X("Botão 2", 10000);
                        AjustarPosicao_X("Botão 3", 10000);
                        AjustarPosicao_X("Botão 4", 10000);
                        AjustarPosicao_X("Botão 5", 10000);
                        AjustarPosicao_X("Botão 6", 10000);
                        AjustarPosicao_X("Botão 7", 10000);
                        AjustarPosicao_X("Botão 8", 10000);
                        AjustarPosicao_X("Botão 9", 10000);
                        AjustarPosicao_X("Botão 10", deltaX * 50);
                        AjustarPosicao_X("Botão 11", deltaX * 50);
                       }
                     else
                        if(sparam == "Botão 7")
                          {
                           botaoSelecionado = 7;
                           PressionarBotao("Botão 7", "Botão 2", "Botão 3", "Botão 4", "Botão 5", "Botão 6", "Botão 1", "Botão 8", "Botão 9", "Botão 10", "Botão 11");

                           AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                           AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                           AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                           AjustarPosicao_X("Botão 10", 10000);
                           AjustarPosicao_X("Botão 11", 10000);

                           //Geração de Relatório 1:
                           int h = FileOpen("Relatório Samurai" + "(" + IntegerToString(horarioAtual_estrutura.day) + "-" +
                                            IntegerToString(horarioAtual_estrutura.mon) + "-" + IntegerToString(horarioAtual_estrutura.year)  +
                                            " " + tempoVelas + ")" + " - Quadrantes.csv",FILE_WRITE|FILE_ANSI|FILE_CSV,";");

                           if(h == INVALID_HANDLE)
                             {
                              Alert("Erro ao gerar relatório! Se estiver com um arquivo de texto/planilha aberto, feche e tente novamente.");
                              return;
                             }

                           FileWrite(h,"Relatório"
                                     "\r\n"
                                     "Samurai"
                                     "\r\n"
                                     "\r\n"
                                     "TF: " + "(M" + IntegerToString(Period()) + ")"
                                     "\r\n"
                                     "\r\n"
                                     "Data"
                                     "\r\n"
                                     "(" + TimeToString(TimeCurrent(),TIME_DATE) + ")"
                                     "\r\n"
                                     "\r\n"
                                     "Quadrante","","","","","","","Maioria",
                                     "1 = 2", "2 = 3","3 = 4", "4 = 5", "5 = 6","6 = 1",
                                     "MQ = 1", "M3P = 4", "M3M = 5", "M3M2 = 6", "M3U = 1",
                                     "1 <> 2", "2 <> 3","3 <> 4", "4 <> 5", "5 <> 6","6 <> 1",
                                     "MQ <> 1", "M3P <> 4", "M3M <> 5", "M3M2 <> 6", "M3U <> 1");

                           //--- NÃO ESTÁ MOSTRANDO NADA NA PLANILHA!!!
                           for(int linha = katanaBarreira; linha < ArrayRange(quadranteVelas_6horarioNegociacao, 0); linha++)
                             {
                              FileWrite(h,TimeToString(periodoVelas_quadrante6Horario_negociacao[linha][0]),
                                        quadranteVelas_6horarioNegociacao[linha][0],
                                        quadranteVelas_6horarioNegociacao[linha][1],
                                        quadranteVelas_6horarioNegociacao[linha][2],
                                        quadranteVelas_6horarioNegociacao[linha][3],
                                        quadranteVelas_6horarioNegociacao[linha][4],
                                        quadranteVelas_6horarioNegociacao[linha][5],
                                        maioriaVelas_horarioNegociacao[linha][1],
                                        umPara2_PDRHorario_negociacao[linha][1],
                                        doisPara3_PDRHorario_negociacao[linha][1],
                                        tresPara4_PDRHorario_negociacao[linha][1],
                                        quatroPara5_PDRHorario_negociacao[linha][1],
                                        cincoPara6_PDRHorario_negociacao[linha][1],
                                        seisPara1_PDRHorario_negociacao[linha][1],
                                        maioriaVelas_para1PDR_horarioNegociacao[linha][1],
                                        maioriaTres_primeirasPara4_PDRHorario_negociacao[linha][1],
                                        maioriaTres_meioPara5_PDRHorario_negociacao[linha][1],
                                        maioriaTres_meioM5_altPara6_PDRHorario_negociacao[linha][1],
                                        maioriaTres_ultimasPara1_PDRHorario_negociacao[linha][1],
                                        umPara2_INVHorario_negociacao[linha][1],
                                        doisPara3_INVHorario_negociacao[linha][1],
                                        tresPara4_INVHorario_negociacao[linha][1],
                                        quatroPara5_INVHorario_negociacao[linha][1],
                                        cincoPara6_INVHorario_negociacao[linha][1],
                                        seisPara1_INVHorario_negociacao[linha][1],
                                        maioriaVelas_para1INV_horarioNegociacao[linha][1],
                                        maioriaTres_primeirasPara4_INVHorario_negociacao[linha][1],
                                        maioriaTres_meioPara5_INVHorario_negociacao[linha][1],
                                        maioriaTres_meioM5_altPara6_INVHorario_negociacao[linha][1],
                                        maioriaTres_ultimasPara1_INVHorario_negociacao[linha][1]
                                       );
                             }

                           FileClose(h);

                           //Geração de Relatório 2:
                           int i = FileOpen("Relatório Samurai" + "(" + IntegerToString(horarioAtual_estrutura.day) + "-" +
                                            IntegerToString(horarioAtual_estrutura.mon) + "-" + IntegerToString(horarioAtual_estrutura.year) +
                                            " " + tempoVelas +  ")" + " - Estatísticas.csv",FILE_WRITE|FILE_ANSI|FILE_CSV,";");

                           if(i == INVALID_HANDLE)
                             {
                              Alert("Erro ao gerar relatório!");
                              return;
                             }

                           FileWrite(i,"Relatório"
                                     "\r\n"
                                     "Samurai"
                                     "\r\n"
                                     "\r\n"
                                     "TF: " + "(M" + IntegerToString(Period()) + ")"
                                     "\r\n"
                                     "\r\n"
                                     "Data"
                                     "\r\n"
                                     "(" + TimeToString(TimeCurrent(),TIME_DATE) + ")"
                                     "\r\n"
                                     "\r\n"
                                     "Ocorrências:"
                                     "\r\n"
                                     "Lugar", "Estratégia", "(%)");

                           for(int linha = 0; linha < ArrayRange(tabelaFinal_ocorrencias, 0); linha++)
                             {
                              FileWrite(i,tabelaFinal_ocorrencias[linha][0],
                                        tabelaFinal_ocorrencias[linha][1],
                                        tabelaFinal_ocorrencias[linha][2]
                                       );
                             }

                           FileWrite(i,
                                     "\r\n"
                                     "\r\n"
                                     "Assertividade:"
                                     "\r\n"
                                     "Lugar", "Estratégia", "Assert. (%)");

                           for(int linha = 0; linha < ArrayRange(tabelaFinal_ocorrencias, 0); linha++)
                             {
                              FileWrite(i,tabelaFinal_assertividade[linha][0],
                                        tabelaFinal_assertividade[linha][1],
                                        tabelaFinal_assertividade[linha][2]
                                       );
                             }

                           FileClose(i);

                           //Geração de Relatório 3:
                           int j = FileOpen("Relatório Samurai" + "(" + IntegerToString(horarioAtual_estrutura.day) + "-" +
                                            IntegerToString(horarioAtual_estrutura.mon) + "-" + IntegerToString(horarioAtual_estrutura.year) +
                                            " " + tempoVelas +  ")" + " - Histórico de Operações.csv",FILE_WRITE|FILE_ANSI|FILE_CSV,";");

                           if(j == INVALID_HANDLE)
                             {
                              Alert("Erro ao gerar relatório!");
                              return;
                             }

                           FileWrite(j,"Relatório"
                                     "\r\n"
                                     "Samurai"
                                     "\r\n"
                                     "\r\n"
                                     "TF: " + "(M" + IntegerToString(Period()) + ")"
                                     "\r\n"
                                     "\r\n"
                                     "Data"
                                     "\r\n"
                                     "(" + TimeToString(TimeCurrent(),TIME_DATE) + ")"
                                     "\r\n"
                                     "\r\n"
                                     "Operações:"
                                     "\r\n"
                                     "Estratégia", "Data Início", "Data Fim", "Resultado");

                           //--- QUE TAL COLOCAR NÚMERO DE VITÓRIAS E DERROTAS E A PORCENTAGEM DE ACERTOS?!!! TALVEZ SEJA INTERESSANTE TRABALHAR COM ANÁLISE DE STOP LOSS
                           for(int linha = 0; linha < ArrayRange(tabelaFinal_historicoEntradas, 0); linha++)
                             {
                              TimeToStruct(StringToTime(tabelaFinal_historicoEntradas[linha][1]), tabelaFinal_historicoEntradas_colunaData_Estrutura1);
                              TimeToStruct(StringToTime(tabelaFinal_historicoEntradas[linha][2]), tabelaFinal_historicoEntradas_colunaData_Estrutura2);

                              FileWrite(i,tabelaFinal_historicoEntradas[linha][0],
                                        IntegerToString(tabelaFinal_historicoEntradas_colunaData_Estrutura1.day) + "/" + IntegerToString(tabelaFinal_historicoEntradas_colunaData_Estrutura1.mon) + "/" + IntegerToString(tabelaFinal_historicoEntradas_colunaData_Estrutura1.year) + "/ " + TimeToString(StructToTime(tabelaFinal_historicoEntradas_colunaData_Estrutura1), TIME_MINUTES|TIME_SECONDS),
                                        IntegerToString(tabelaFinal_historicoEntradas_colunaData_Estrutura2.day) + "/" + IntegerToString(tabelaFinal_historicoEntradas_colunaData_Estrutura2.mon) + "/" + IntegerToString(tabelaFinal_historicoEntradas_colunaData_Estrutura2.year) + "/ " + TimeToString(StructToTime(tabelaFinal_historicoEntradas_colunaData_Estrutura2), TIME_MINUTES|TIME_SECONDS),
                                        tabelaFinal_historicoEntradas[linha][3]
                                       );
                             }
                           FileClose(i);
                          }
                        else
                           if(sparam == "Botão 8")
                             {
                              botaoSelecionado = 8;
                              PressionarBotao("Botão 8", "Botão 1", "Botão 2", "Botão 3", "Botão 4", "Botão 5", "Botão 5", "Botão 7", "Botão 9", "Botão 10", "Botão 11");

                              AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                              AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                              AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                              AjustarPosicao_X("Botão 10", 10000);
                              AjustarPosicao_X("Botão 11", 10000);
                             }
                           else
                              if(sparam == "Botão 9" && mostrarPainel == true)
                                {
                                 PressionarBotao("Botão 9", "Botão 1", "Botão 2", "Botão 3", "Botão 4", "Botão 5", "Botão 5", "Botão 7", "Botão 8", "Botão 10", "Botão 11");
                                 mostrarPainel = false;
                                 BotaoOcultar(botaoSelecionado, mostrarPainel);
                                 ApagarTexto_Painel(legendasPainel1_botao1Vertical_label,
                                                    legendasPainel1_botao2Vertical_label,
                                                    legendasPainel1_botao7Vertical_label,
                                                    legendasPainel1_botao8Vertical_label,
                                                    legendasPainel1_botao2Horizontal_M1Label,
                                                    legendasPainel1_botao2Horizontal_M5Label,
                                                    legendasPainel1_botao2Horizontal_M15Label,
                                                    legendasPainel1_botao4Horizontal,
                                                    legendasPainel1_botao4Horizontal_label,
                                                    legendasPainel2_entradaLabel,
                                                    legendasPainel2_quadranteAtual_M1Label,
                                                    legendasPainel2_quadranteAtual_M5Label,
                                                    legendasPainel2_quadranteAtual_M15Label,
                                                    valoresPainel1_botao1Label,
                                                    quadrantePainel1_botao2Label,
                                                    valoresPainel1_botao2Label_M1,
                                                    valoresPainel1_botao2Label_M5,
                                                    valoresPainel1_botao2Label_M15,
                                                    valoresPainel1_botao2MaioriaQ_M1Label,
                                                    valoresPainel1_botao2MaioriaQ_M5Label,
                                                    valoresPainel1_botao2MaioriaQ_M15Label,
                                                    valoresPainel1_botao2Maioria_3primeirasM1_label,
                                                    valoresPainel1_botao2Maioria_3primeirasM5_label,
                                                    valoresPainel1_botao2Maioria_3primeirasM15_label,
                                                    valoresPainel1_botao2Maioria_3meioM1_label,
                                                    valoresPainel1_botao2Maioria_3meioM5_label,
                                                    valoresPainel1_botao2Maioria_3meioM5_altLabel,
                                                    valoresPainel1_botao2Maioria_3ultimasM1_label,
                                                    valoresPainel1_botao2Maioria_3ultimasM5_label,
                                                    valoresPainel1_botao2Maioria_3ultimasM15_label,
                                                    valoresPainel1_botao3Label,
                                                    valoresPainel1_botao4Label,
                                                    valoresPainel1_botao5Label,
                                                    valoresPainel1_botao8Label,
                                                    valoresPainel2_entradaLabel,
                                                    valoresPainel2_quadranteAtual_label,
                                                    valoresPainel3_botao3Label,
                                                    valoresPainel3_botao5Label);

                                 ObjectDelete(0, "statusPainel2");


                                 for(int i = 1; i <= 2; i++)
                                   {
                                    AjustarPosicao_X("Seta " + IntegerToString(i), 10000);
                                   }

                                 AjustarPosicao_X("Botao Inicio", 10000);
                                 AjustarPosicao_X("Botao Fim", 10000);
                                 AjustarPosicao_X("Meditando", 10000);
                                 AjustarPosicao_X("Katana", 10000);
                                 AjustarPosicao_X("Logo Samurai", 10000);
                                 AjustarPosicao_X("Logo Titulo", 10000);
                                 AjustarPosicao_X("Logo TM", 10000);
                                 AjustarPosicao_X("Quadrante Atual", 10000);
                                 AjustarPosicao_X("Fundo 3", 10000);
                                 AjustarPosicao_X("Botão 10", 10000);
                                 AjustarPosicao_X("Botão 11", 10000);
                                }

                              else
                                 if(sparam == "Botão 9" && mostrarPainel == false)
                                   {
                                    mostrarPainel = true;
                                    botaoSelecionado = botaoSelecionado;
                                    BotaoOcultar(botaoSelecionado, mostrarPainel);
                                    if(tabelaEntrada[indiceEntrada][3] == "AGUARDE")
                                      {
                                       AjustarPosicao_X("Meditando", deltaX * 64 + 5);
                                       AjustarPosicao_X("Katana", 10000);
                                      }
                                    else
                                      {
                                       AjustarPosicao_X("Meditando", 10000);
                                       AjustarPosicao_X("Katana", deltaX * 64 + 5);
                                      }
                                    AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                                    AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                                    AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                                    AjustarPosicao_X("Quadrante Atual", deltaX * 74 + 5);
                                    AjustarPosicao_X("Botão 10", 10000);
                                    AjustarPosicao_X("Botão 11", 10000);
                                   }
                                 else
                                    if(sparam == "Botão 10")
                                      {
                                       confirmacaoTestes = true;

                                       AjustarPosicao_X("Fundo 1", deltaX);
                                       AjustarPosicao_X("Fundo 2", deltaX * 63);
                                       AjustarAltura_Painel("Fundo 2", deltaY * 30 + 5, deltaY * 30 + 1, false, 1);
                                       AjustarPosicao_X("Fundo 3", 10000);
                                       AjustarPosicao_Y("Fundo 3", deltaY * 43);
                                       AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                                       AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                                       AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                                       AjustarPosicao_X("Meditando", 10000);
                                       AjustarPosicao_X("Katana", 10000);
                                       AjustarPosicao_X("Botão 1", 10000);
                                       AjustarPosicao_X("Botão 2", 10000);
                                       AjustarPosicao_X("Botão 3", 10000);
                                       AjustarPosicao_X("Botão 4", 10000);
                                       AjustarPosicao_X("Botão 5", 10000);
                                       AjustarPosicao_X("Botão 6", 10000);
                                       AjustarPosicao_X("Botão 7", 10000);
                                       AjustarPosicao_X("Botão 8", 10000);
                                       AjustarPosicao_X("Botão 9", 10000);
                                       AjustarPosicao_X("Botão 10", 10000);
                                       AjustarPosicao_X("Botão 11", 10000);
                                       AjustarPosicao_X("Botão 12", deltaX * 50);
                                       AjustarPosicao_X("Botão 13", deltaX * 50);
                                       AjustarPosicao_X("Botão 14", deltaX * 50);
                                       AjustarPosicao_X("Botão 15", deltaX * 50);
                                      }
                                    else
                                       if(sparam == "Botão 11")
                                         {
                                          mostrarPainel = true;
                                          botaoSelecionado = 8;

                                          AjustarPosicao_X("Fundo 1", deltaX);
                                          AjustarPosicao_X("Fundo 2", deltaX * 63);
                                          AjustarPosicao_X("Fundo 3", 10000);
                                          AjustarPosicao_Y("Fundo 3", deltaY * 43);
                                          AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                                          AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                                          AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                                          AjustarPosicao_X("Meditando", deltaX * 64 + 5);
                                          AjustarPosicao_X("Botão 10", 10000);
                                          AjustarPosicao_X("Botão 11", 10000);
                                          AjustarPosicao_X("Botão 1", deltaX * 50);
                                          AjustarPosicao_X("Botão 2", deltaX * 50);
                                          AjustarPosicao_X("Botão 3", deltaX * 50);
                                          AjustarPosicao_X("Botão 4", deltaX * 50);
                                          AjustarPosicao_X("Botão 5", deltaX * 50);
                                          AjustarPosicao_X("Botão 6", deltaX * 50);
                                          AjustarPosicao_X("Botão 7", deltaX * 50);
                                          AjustarPosicao_X("Botão 8", deltaX * 50);
                                          AjustarPosicao_X("Botão 9", deltaX * 50);
                                         }
                                       else
                                          if(sparam == "Botão 12")
                                            {
                                             Print("Botão 12");
                                             botaoSelecionado = 12;
                                            }
                                          else
                                             if(sparam == "Botão 13")
                                               {
                                                Print("Botão 13");
                                                botaoSelecionado = 13;
                                               }
                                             else
                                                if(sparam == "Botão 14")
                                                  {
                                                   Print("Botão 14");
                                                   botaoSelecionado = 14;
                                                  }
                                                else
                                                   if(sparam == "Botão 15")
                                                     {
                                                      mostrarPainel = true;
                                                      botaoSelecionado = 1;
                                                      BotaoOcultar(botaoSelecionado, mostrarPainel);
                                                      if(tabelaEntrada[indiceEntrada][3] == "AGUARDE")
                                                        {
                                                         AjustarPosicao_X("Meditando", deltaX * 64 + 5);
                                                         AjustarPosicao_X("Katana", 10000);
                                                        }
                                                      else
                                                        {
                                                         AjustarPosicao_X("Meditando", 10000);
                                                         AjustarPosicao_X("Katana", deltaX * 64 + 5);
                                                        }
                                                      AjustarPosicao_X("Logo Samurai", deltaX * 64 + 7);
                                                      AjustarPosicao_X("Logo Titulo", deltaX * 74 + 5);
                                                      AjustarPosicao_X("Logo TM", deltaX * 100 + 5);
                                                      AjustarPosicao_X("Quadrante Atual", deltaX * 74 + 5);
                                                      AjustarPosicao_X("Botão 9", 500);
                                                      AjustarPosicao_X("Botão 10", 10000);
                                                      AjustarPosicao_X("Botão 11", 10000);
                                                     }
                                                   else
                                                      if(sparam == "Seta 1" && botaoSelecionado == 2)
                                                        {
                                                         AvancarIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                                                        }
                                                      else
                                                         if(sparam == "Seta 1" && botaoSelecionado == 4)
                                                           {
                                                            AvancarIndices(ArrayRange(valoresPainel1_botao4Label, 0), diferencaIndice_botao4, indiceMaximo_vetorAtual_botao4, indiceMinimo_vetorAtual_botao4);
                                                           }
                                                         else
                                                            if(sparam == "Seta 2" && botaoSelecionado == 2)
                                                              {
                                                               RecuarIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                                                              }
                                                            else
                                                               if(sparam == "Seta 2" && botaoSelecionado == 4)
                                                                 {
                                                                  RecuarIndices(ArrayRange(valoresPainel1_botao4Label, 0), diferencaIndice_botao4, indiceMaximo_vetorAtual_botao4, indiceMinimo_vetorAtual_botao4);
                                                                 }
                                                               else
                                                                  if(sparam == "Botao Inicio" && botaoSelecionado == 2)
                                                                    {
                                                                     InicioIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                                                                    }
                                                                  else
                                                                     if(sparam == "Botao Inicio" && botaoSelecionado == 4)
                                                                       {
                                                                        InicioIndices(ArrayRange(valoresPainel1_botao4Label, 0), diferencaIndice_botao4, indiceMaximo_vetorAtual_botao4, indiceMinimo_vetorAtual_botao4);
                                                                       }
                                                                     else
                                                                        if(sparam == "Botao Fim" && botaoSelecionado == 2)
                                                                          {
                                                                           FinalIndices(numeroLinhas, diferencaIndice_botao2, indiceMaximo_vetorAtual_botao2, indiceMinimo_vetorAtual_botao2);
                                                                          }
                                                                        else
                                                                           if(sparam == "Botao Fim" && botaoSelecionado == 4)
                                                                             {
                                                                              FinalIndices(ArrayRange(valoresPainel1_botao4Label, 0), diferencaIndice_botao4, indiceMaximo_vetorAtual_botao4, indiceMinimo_vetorAtual_botao4);
                                                                             }

     }
  }

//+------------------------------------------------------------------+
//| OBSERVAÇÕES                                                      |
//+------------------------------------------------------------------+
//--- 2021.10.07 06:04:00.082 RoboSamurai (EURUSD,M1) array out of range in 'RS_funcoesEstrategias.mqh' (3282,114)
//--- ALGUMAS ESTRATÉGIAS APRESENTAM CONTADOR EM ASSERTIVIDADE ASSIM QUE COMEÇAM A APARECER!!!
//--- 4 <> 5/1 AVISA NA HORA DA ENTRADA!!!
//--- CONSERTAR VISUALIZAÇÃO DE HISTÓRICO DE ENTRADAS E ASSERTIVIDADE DE ACORDO COM POSIÇÕES (COMO FOI FEITO EM OCORRÊNCIAS)
//--- DERROTA DO QUADRANTE COMPLEMENTAR NÃO ESTÁ SENDO COMPUTADA EM ASSERTIVIDADE E HISTÓRICO
//--- ALERTA COM VELA CORRENTE É DESNECESSÁRIO (CHECAR QUANDO VELA TERMINA PARA EVITAR FALSOS SINAIS)
//--- COMPLEMENTAÇÃO FALHA EM ALGUM HORÁRIO (???)
//--- RESOLVER INVERSÃO DO PAINEL INFO (QUANDO TROCA PARÂMETROS?)
//--- RELATÓRIO MOSTRA QUE A COMPLEMENTAÇÃO NÃO ESTÁ FUNCIONANDO (FICA FALTANDO UM HORÁRIO DE ANÁLISE)
//--- BOTÃO DE TESTE (7 DIAS? 30 DIAS? 180 DIAS? 360 DIAS?)
//---                - INPUT DE DIAS PARA REGRESSÃO
//---                - ATRASO DE ALGUNS SEGUNDOS PARA REGREDIR? (PARA NÃO EXPLODIR O PROCESSADOR)
//---                - COLOCA TRUE EM VARIÁVEL BOOL UNIVERSAL
//---                - COPIA VARIÁVEIS ATUAIS
//---                - REGRIDE UM DIA NA DATA DE INÍCIO
//---                - ACRESCE RESULTADOS ÀS VARIÁVEIS
//--- FALTA NAS INFORMAÇÕES O MÉTODO DE POSIÇÕES E TALVEZ DIAS PARA TESTES
//--- FAZER AS PRÓPRIAS LINHAS PARA NÃO DEPENDER DO INDICADOR TIME RANGE SEPARATOR
//---    INCLUIR LINHAS ESPECIAIS (INÍCIO DA ANÁLISE, INÍCIO DAS OPERAÇÕES E DO FIM)
//--- EM ASSERTIVIDADE, APENAS PORCENTAGEM CONTRIBUE PARA O RANKING (MAIOR NÚMERO DE VITÓRIAS/DERROTAS NÃO)
//--- MAIORIAS DE QUADRANTE ATUAL PERMANECEM QUANDO ELE ESTÁ VAZIO (APLICAR MESMAS REGRAS)
//--- M3M GRÁFICA ESTÁ ERRADO!!! (PRECISA REALMENTE?)
//--- QUE TAL APAGAR QUADRANTE ATUAL QUANDO NÃO HOUVER NADA? (MESMA REGRA)
//--- BUG NA FUNÇÃO FILTRARCOPIA_ANOMALIAS FALTANDO 25 MINUTOS PARA INÍCIO DAS OPERAÇÕES: (CONSERTADO??? TIROU O "=" DO ">=" FICANDO APENAS ">")
//--- OM 2  05:35:00.569   RoboSamurai (EURUSD,M1) array out of range in 'RS_funcoesTempo.mqh' (197,25) (CONSERTADO??? VIDE ACIMA)
//--- COMPLEMENTAÇÃO DE ESTRATÉGIA COM DUAS POSIÇÕES DANDO PROBLEMA:
//--- RR 2  07:06:19.808   RoboSamurai (EURUSD,M1) array out of range in 'RS_funcoesEstrategias.mqh' (2548,216)
//--- COMPUTOU UMA DERROTA DE 4 = 5 COMO VITÓRIA DE 5 <> 1 (!!!)
//--- OU NO HISTÓRICO OU MESMO NA AVALIAÇÃO DO RESULTADO A "PULADA" DO DOJI PARECE FAZER COISAS GROTESCAS COM AS ESTRATÉGIAS
//--- (M3M = 5 17/08/2021 10:36 ~ 11:01)
//--- HISTÓRICO DEMORA A ATUALIZAR E ATUALIZA AUTOMATICAMENTE SOMENTE APÓS REINICIALIZAR O ROBÔ

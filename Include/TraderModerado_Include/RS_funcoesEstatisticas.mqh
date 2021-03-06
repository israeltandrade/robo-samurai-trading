//+------------------------------------------------------------------+
//|                                       ES_funcoesEstatisticas.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| CALCULAR OCORRÊNCIAS                                             |
//+------------------------------------------------------------------+
//--- Cálculo de Ocorrências Padrão (PDR - PROCEDIMENTO)
void   CalcularOcorrencias_PDR(int   numeroLinhas_funcao, string   &matrizEstrategia_funcao[][2], double &ocorrenciasPDR_funcao[][2])
  {
   int   ocorrenciasPDR_calculadas = 0;
   int   ocorrenciasOSS_calculadas = 0;

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(matrizEstrategia_funcao[i][1] == "PDR")
        {
         ocorrenciasPDR_calculadas++;
        }
      else
         if(matrizEstrategia_funcao[i][1] == "OSS")
           {
            ocorrenciasOSS_calculadas++;
           }
     }

   ocorrenciasPDR_funcao[0][0] = ocorrenciasPDR_calculadas;
   ocorrenciasPDR_funcao[0][1] = ocorrenciasOSS_calculadas;
  }

//--- Cálculo de Ocorrências Invertidas (INV - PROCEDIMENTO)
void   CalcularOcorrencias_INV(int   numeroLinhas_funcao, string   &matrizEstrategia_funcao[][2], double &ocorrenciasINV_funcao[][2])
  {
   int   ocorrenciasINV_calculadas = 0;
   int   ocorrenciasOSS_calculadas = 0;

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(matrizEstrategia_funcao[i][1] == "INV")
        {
         ocorrenciasINV_calculadas++;
        }
      else
         if(matrizEstrategia_funcao[i][1] == "OSS")
           {
            ocorrenciasOSS_calculadas++;
           }
     }

   ocorrenciasINV_funcao[0][0] = ocorrenciasINV_calculadas;
   ocorrenciasINV_funcao[0][1] = ocorrenciasOSS_calculadas;
  }

//--- Cálculo de Porcentagem (%) de Ocorrências (DOUBLE - FUNÇÃO)
double CalcularPorcentagem_Ocorrencias(double  acertosOcorrencias_funcao, double   errosOcorrencias_funcao)
  {
   double   porcentagemCalculada = 0.0;

   if((acertosOcorrencias_funcao + errosOcorrencias_funcao) != 0)
     {
      porcentagemCalculada = NormalizeDouble(acertosOcorrencias_funcao * 100 / (acertosOcorrencias_funcao + errosOcorrencias_funcao), 2);
     }

   return   porcentagemCalculada;
  }

//--- Cálculo de Assertividade das Estratégias PDR
double   CalcularAssertividade_PDR(string  &matrizEstrategia_funcao[][2], int katanaBarreira_funcao, double   &quantidadeVitoria_katanaPDR_funcao, double   &quantidadeDerrota_katanaPDR_funcao, bool  porcentagemBarreira_funcao, double porcentagemOcorrencias_funcao, double mediaPorcentagem_ocorrenciasFuncao, string   &matrizEntradas_funcao[][4], string  alias)
  {
   string     matrizEstrategia_copiaFuncao[][2];
   string     matrizEntradas_provisoriaFuncao[][4];
   int        numeroLinhas_funcao = 0;
   int        numeroLinhas_copiaFuncao = 0;
   int        numeroLinhas_entradasFuncao = 0;
   int        diferencaIndice_funcao = 2 + katanaBarreira_funcao;
   int        contadorExcesso_funcao = 0;
   int        contadorLoss_funcao = 0;
   int        excessoEntradas_funcao = 0;
   double     assertividadeCalculada_funcao = 0;
   int        j = 0;
   int        l = 0;

   if((porcentagemBarreira_funcao == true && porcentagemOcorrencias_funcao >= mediaPorcentagem_ocorrenciasFuncao) ||
      (porcentagemBarreira_funcao == false))
     {
      numeroLinhas_funcao = ArrayRange(matrizEstrategia_funcao, 0);
      ArrayResize(matrizEstrategia_copiaFuncao, numeroLinhas_funcao, 0);

      for(int i = 0; i < numeroLinhas_funcao; i++)
        {
         if(matrizEstrategia_funcao[i][1] == "PDR" || matrizEstrategia_funcao[i][1] == "OSS")
           {
            matrizEstrategia_copiaFuncao[j][0] = matrizEstrategia_funcao[i][0];
            matrizEstrategia_copiaFuncao[j][1] = matrizEstrategia_funcao[i][1];
            j += 1;
           }
         else
           {
            contadorExcesso_funcao += 1;
           }
        }

      ArrayResize(matrizEstrategia_copiaFuncao, numeroLinhas_funcao - contadorExcesso_funcao, 0);

      numeroLinhas_copiaFuncao = ArrayRange(matrizEstrategia_copiaFuncao, 0);

      ArrayResize(matrizEntradas_provisoriaFuncao, numeroLinhas_copiaFuncao, 0);

      for(int i = 0; i <= (numeroLinhas_copiaFuncao - diferencaIndice_funcao -1); i++)
        {
         for(int k = i + 1; k < (i + diferencaIndice_funcao -1); k++)
           {
            if(matrizEstrategia_copiaFuncao[k][1] == "OSS")
              {
               contadorLoss_funcao += 1;
              }
           }

         if(matrizEstrategia_copiaFuncao[i][1] == "PDR" &&
            contadorLoss_funcao == katanaBarreira_funcao &&
            matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][1] == "PDR")
           {
            quantidadeVitoria_katanaPDR_funcao += 1;
            matrizEntradas_provisoriaFuncao[i][0] = alias;
            matrizEntradas_provisoriaFuncao[i][1] = matrizEstrategia_copiaFuncao[i][0];
            matrizEntradas_provisoriaFuncao[i][2] = matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][0];
            matrizEntradas_provisoriaFuncao[i][3] = " VITÓRIA";
           }
         else
            if(matrizEstrategia_copiaFuncao[i][1] == "PDR" &&
               contadorLoss_funcao == katanaBarreira_funcao &&
               matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][1] == "OSS")
              {
               quantidadeDerrota_katanaPDR_funcao -= 1;
               matrizEntradas_provisoriaFuncao[i][0] = alias;
               matrizEntradas_provisoriaFuncao[i][1] = matrizEstrategia_copiaFuncao[i][0];
               matrizEntradas_provisoriaFuncao[i][2] = matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][0];
               matrizEntradas_provisoriaFuncao[i][3] = "DERROTA";
              }
            else
              {
               excessoEntradas_funcao += 1;
              }
         contadorLoss_funcao = 0;
        }

      numeroLinhas_entradasFuncao = numeroLinhas_copiaFuncao - excessoEntradas_funcao - diferencaIndice_funcao;
      ArrayResize(matrizEntradas_funcao, numeroLinhas_entradasFuncao, 0);

      for(int i = 0; i < numeroLinhas_copiaFuncao; i++)
        {
         if(matrizEntradas_provisoriaFuncao[i][0] != NULL)
           {
            matrizEntradas_funcao[l][0] = matrizEntradas_provisoriaFuncao[i][0];
            matrizEntradas_funcao[l][1] = matrizEntradas_provisoriaFuncao[i][1];
            matrizEntradas_funcao[l][2] = matrizEntradas_provisoriaFuncao[i][2];
            matrizEntradas_funcao[l][3] = matrizEntradas_provisoriaFuncao[i][3];
            l += 1;
           }
        }

      if((quantidadeVitoria_katanaPDR_funcao > quantidadeDerrota_katanaPDR_funcao * -1) &&
         (quantidadeVitoria_katanaPDR_funcao - quantidadeDerrota_katanaPDR_funcao) != 0)
        {
         assertividadeCalculada_funcao = NormalizeDouble(quantidadeVitoria_katanaPDR_funcao / (quantidadeVitoria_katanaPDR_funcao - quantidadeDerrota_katanaPDR_funcao) * 100,2);
        }
      else
         if((quantidadeVitoria_katanaPDR_funcao < quantidadeDerrota_katanaPDR_funcao * -1) &&
            (quantidadeVitoria_katanaPDR_funcao - quantidadeDerrota_katanaPDR_funcao) != 0)
           {
            assertividadeCalculada_funcao = NormalizeDouble(quantidadeDerrota_katanaPDR_funcao / (quantidadeVitoria_katanaPDR_funcao - quantidadeDerrota_katanaPDR_funcao) * 100, 2);
           }
         else
           {
            assertividadeCalculada_funcao = 0;
           }
     }

   return assertividadeCalculada_funcao;
  }

//--- Cálculo de Assertividade das Estratégias INV
double   CalcularAssertividade_INV(string  &matrizEstrategia_funcao[][2], int katanaBarreira_funcao, double   &quantidadeVitoria_katanaINV_funcao, double   &quantidadeDerrota_katanaINV_funcao, bool  porcentagemBarreira_funcao, double porcentagemOcorrencias_funcao, double mediaPorcentagem_ocorrenciasFuncao, string   &matrizEntradas_funcao[][4], string  alias)
  {
   string     matrizEstrategia_copiaFuncao[][2];
   string     matrizEntradas_provisoriaFuncao[][4];
   int        numeroLinhas_funcao = 0;
   int        numeroLinhas_copiaFuncao = 0;
   int        numeroLinhas_entradasFuncao = 0;
   int        diferencaIndice_funcao = 2 + katanaBarreira_funcao;
   int        contadorExcesso_funcao = 0;
   int        contadorLoss_funcao = 0;
   int        excessoEntradas_funcao = 0;
   double     assertividadeCalculada_funcao = 0;
   int        j = 0;
   int        l = 0;

   if((porcentagemBarreira_funcao == true && porcentagemOcorrencias_funcao >= mediaPorcentagem_ocorrenciasFuncao) ||
      (porcentagemBarreira_funcao == false))
     {
      numeroLinhas_funcao = ArrayRange(matrizEstrategia_funcao, 0);
      ArrayResize(matrizEstrategia_copiaFuncao, numeroLinhas_funcao, 0);

      for(int i = 0; i < numeroLinhas_funcao; i++)
        {
         if(matrizEstrategia_funcao[i][1] == "INV" || matrizEstrategia_funcao[i][1] == "OSS")
           {
            matrizEstrategia_copiaFuncao[j][0] = matrizEstrategia_funcao[i][0];
            matrizEstrategia_copiaFuncao[j][1] = matrizEstrategia_funcao[i][1];
            j += 1;
           }
         else
           {
            contadorExcesso_funcao += 1;
           }
        }

      ArrayResize(matrizEstrategia_copiaFuncao, numeroLinhas_funcao - contadorExcesso_funcao, 0);

      numeroLinhas_copiaFuncao = ArrayRange(matrizEstrategia_copiaFuncao, 0);

      ArrayResize(matrizEntradas_provisoriaFuncao, numeroLinhas_copiaFuncao, 0);

      for(int i = 0; i <= (numeroLinhas_copiaFuncao - diferencaIndice_funcao -1); i++)
        {
         for(int k = i + 1; k < (i + diferencaIndice_funcao -1); k++)
           {
            if(matrizEstrategia_copiaFuncao[k][1] == "OSS")
              {
               contadorLoss_funcao += 1;
              }
           }

         if(matrizEstrategia_copiaFuncao[i][1] == "INV" &&
            contadorLoss_funcao == katanaBarreira_funcao &&
            matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][1] == "INV")
           {
            quantidadeVitoria_katanaINV_funcao += 1;
            matrizEntradas_provisoriaFuncao[i][0] = alias;
            matrizEntradas_provisoriaFuncao[i][1] = matrizEstrategia_copiaFuncao[i][0];
            matrizEntradas_provisoriaFuncao[i][2] = matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][0];
            matrizEntradas_provisoriaFuncao[i][3] = " VITÓRIA";
           }
         else
            if(matrizEstrategia_copiaFuncao[i][1] == "INV" &&
               contadorLoss_funcao == katanaBarreira_funcao &&
               matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][1] == "OSS")
              {
               quantidadeDerrota_katanaINV_funcao -= 1;
               matrizEntradas_provisoriaFuncao[i][0] = alias;
               matrizEntradas_provisoriaFuncao[i][1] = matrizEstrategia_copiaFuncao[i][0];
               matrizEntradas_provisoriaFuncao[i][2] = matrizEstrategia_copiaFuncao[i + diferencaIndice_funcao -1][0];
               matrizEntradas_provisoriaFuncao[i][3] = "DERROTA";
              }
            else
              {
               excessoEntradas_funcao += 1;
              }
         contadorLoss_funcao = 0;
        }

      numeroLinhas_entradasFuncao = numeroLinhas_copiaFuncao - excessoEntradas_funcao - diferencaIndice_funcao;
      ArrayResize(matrizEntradas_funcao, numeroLinhas_entradasFuncao, 0);

      for(int i = 0; i < numeroLinhas_copiaFuncao; i++)
        {
         if(matrizEntradas_provisoriaFuncao[i][0] != NULL)
           {
            matrizEntradas_funcao[l][0] = matrizEntradas_provisoriaFuncao[i][0];
            matrizEntradas_funcao[l][1] = matrizEntradas_provisoriaFuncao[i][1];
            matrizEntradas_funcao[l][2] = matrizEntradas_provisoriaFuncao[i][2];
            matrizEntradas_funcao[l][3] = matrizEntradas_provisoriaFuncao[i][3];
            l += 1;
           }
        }

      if((quantidadeVitoria_katanaINV_funcao > quantidadeDerrota_katanaINV_funcao * -1) &&
         (quantidadeVitoria_katanaINV_funcao - quantidadeDerrota_katanaINV_funcao) != 0)
        {
         assertividadeCalculada_funcao = NormalizeDouble(quantidadeVitoria_katanaINV_funcao / (quantidadeVitoria_katanaINV_funcao - quantidadeDerrota_katanaINV_funcao) * 100,2);
        }
      else
         if((quantidadeVitoria_katanaINV_funcao < quantidadeDerrota_katanaINV_funcao * -1) &&
            (quantidadeVitoria_katanaINV_funcao - quantidadeDerrota_katanaINV_funcao) != 0)
           {
            assertividadeCalculada_funcao = NormalizeDouble(quantidadeDerrota_katanaINV_funcao / (quantidadeVitoria_katanaINV_funcao - quantidadeDerrota_katanaINV_funcao) * 100, 2);
           }
         else
           {
            assertividadeCalculada_funcao = 0;
           }
     }

   return assertividadeCalculada_funcao;
  }

//--- Aglutinação de Matrizes Tipo String
void  AglutinarMatrizes_StringM1(string   &matriz1Funcao[][4],  string   &matriz2Funcao[][4],  string   &matriz3Funcao[][4],
                                 string   &matriz4Funcao[][4],  string   &matriz5Funcao[][4],  string   &matriz6Funcao[][4],
                                 string   &matriz7Funcao[][4],  string   &matriz8Funcao[][4],  string   &matriz9Funcao[][4],
                                 string   &matriz10Funcao[][4], string   &matriz11Funcao[][4], string   &matriz12Funcao[][4],
                                 string   &matriz13Funcao[][4], string   &matriz14Funcao[][4], string   &matriz15Funcao[][4],
                                 string   &matriz16Funcao[][4], string   &matriz17Funcao[][4], string   &matriz18Funcao[][4],
                                 string   &tabelaAglutinada_funcao[][4])
  {
   int   contadorTabela_aglutinada = 0;

   ArrayCopy(tabelaAglutinada_funcao, matriz1Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz1Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz2Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz2Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz3Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz3Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz4Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz4Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz5Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz5Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz6Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz6Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz7Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz7Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz8Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz8Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz9Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz9Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz10Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz10Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz11Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz11Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz12Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz12Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz13Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz13Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz14Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz14Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz15Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz15Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz16Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz16Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz17Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz17Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz18Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz18Funcao);

   contadorTabela_aglutinada = 0;
  }

//--- Aglutinação de Matrizes Tipo String
void  AglutinarMatrizes_StringM5(string   &matriz1Funcao[][4],  string   &matriz2Funcao[][4],  string   &matriz3Funcao[][4],
                                 string   &matriz4Funcao[][4],  string   &matriz5Funcao[][4],  string   &matriz6Funcao[][4],
                                 string   &matriz7Funcao[][4],  string   &matriz8Funcao[][4],  string   &matriz9Funcao[][4],
                                 string   &matriz10Funcao[][4], string   &matriz11Funcao[][4], string   &matriz12Funcao[][4],
                                 string   &matriz13Funcao[][4], string   &matriz14Funcao[][4], string   &matriz15Funcao[][4],
                                 string   &matriz16Funcao[][4], string   &matriz17Funcao[][4], string   &matriz18Funcao[][4],
                                 string   &matriz19Funcao[][4], string   &matriz20Funcao[][4], string   &matriz21Funcao[][4],
                                 string   &matriz22Funcao[][4], string   &tabelaAglutinada_funcao[][4])
  {
   int   contadorTabela_aglutinada = 0;

   ArrayCopy(tabelaAglutinada_funcao, matriz1Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz1Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz2Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz2Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz3Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz3Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz4Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz4Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz5Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz5Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz6Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz6Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz7Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz7Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz8Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz8Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz9Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz9Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz10Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz10Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz11Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz11Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz12Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz12Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz13Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz13Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz14Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz14Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz15Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz15Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz16Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz16Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz17Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz17Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz18Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz18Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz19Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz19Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz20Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz20Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz21Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz21Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz22Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz22Funcao);

   contadorTabela_aglutinada = 0;
  }

//--- Aglutinação de Matrizes Tipo String
void  AglutinarMatrizes_StringM15(string   &matriz1Funcao[][4],  string   &matriz2Funcao[][4],  string   &matriz3Funcao[][4],
                                  string   &matriz4Funcao[][4],  string   &matriz5Funcao[][4],  string   &matriz6Funcao[][4],
                                  string   &matriz7Funcao[][4],  string   &matriz8Funcao[][4],  string   &matriz9Funcao[][4],
                                  string   &matriz10Funcao[][4], string   &matriz11Funcao[][4], string   &matriz12Funcao[][4],
                                  string   &matriz13Funcao[][4], string   &matriz14Funcao[][4],
                                  string   &tabelaAglutinada_funcao[][4])
  {
   int   contadorTabela_aglutinada = 0;

   ArrayCopy(tabelaAglutinada_funcao, matriz1Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz1Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz2Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz2Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz3Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz3Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz4Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz4Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz5Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz5Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz6Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz6Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz7Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz7Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz8Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz8Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz9Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz9Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz10Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz10Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz11Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz11Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz12Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz12Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz13Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz13Funcao);

   ArrayCopy(tabelaAglutinada_funcao, matriz14Funcao, contadorTabela_aglutinada, 0, WHOLE_ARRAY);
   contadorTabela_aglutinada += ArraySize(matriz14Funcao);

   contadorTabela_aglutinada = 0;
  }

//+------------------------------------------------------------------+

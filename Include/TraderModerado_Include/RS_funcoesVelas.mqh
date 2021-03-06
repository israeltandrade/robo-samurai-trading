//+------------------------------------------------------------------+
//|                                            ES_funcoesVelas.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"

//--- DEFINIR CANDLES POR QUADRANTE (FUNÇÃO)
int   DefinirQuadrante(int timeframeFuncao)
  {
   int   quadranteDefinido = 6;

   if(timeframeFuncao == PERIOD_M1)
     {
      quadranteDefinido = 5;
     }
   else
      if(timeframeFuncao == PERIOD_M5)
        {
         quadranteDefinido = 6;
        }
      else
         if(timeframeFuncao == PERIOD_M15)
           {
            quadranteDefinido = 4;
           }

         else
           {
            Alert("Esse Expert só funciona nos timeframes de M1, M5 ou M15!");

            ExpertRemove();
           }

   return quadranteDefinido;
  }

//--- DEFINIR DIREÇÃO DAS VELAS (FUNÇÃO)
void   DefinirDirecao_Velas(int &matrizEscolhida_funcao[], int  tamanhoMatriz_funcao, MqlRates &dadosVelas_funcao[])
  {
   ZeroMemory(matrizEscolhida_funcao);
   ArrayResize(matrizEscolhida_funcao, tamanhoMatriz_funcao, 0);

   for(int i = 0; i < ArraySize(matrizEscolhida_funcao); i++)
     {
      if(dadosVelas_funcao[i].close > dadosVelas_funcao[i].open)
        {
         matrizEscolhida_funcao[i] = 1;
        }

      if(dadosVelas_funcao[i].close < dadosVelas_funcao[i].open)
        {
         matrizEscolhida_funcao[i] = 2;
        }

      if(dadosVelas_funcao[i].close == dadosVelas_funcao[i].open)
        {
         matrizEscolhida_funcao[i] = 0;
        }
     }
  }

//--- CONTAR AS VELAS (PROCEDIMENTO)
void  ContarVelas(int &matrizVerificada[], double &velasVerdes_funcao, double &velasVermelhas_funcao, double  &dojis_funcao)
  {
   int contadorVerdes = 0;
   int contadorVermelhas = 0;
   int contadorDojis = 0;

   for(int i = 0; i < ArraySize(matrizVerificada); i++)
     {
      if(matrizVerificada[i] == 1)
        {
         contadorVerdes++;
        }

      if(matrizVerificada[i] == 2)
        {
         contadorVermelhas++;
        }

      if(matrizVerificada[i] == 0)
        {
         contadorDojis++;
        }
     }

   velasVerdes_funcao = contadorVerdes;
   velasVermelhas_funcao = contadorVermelhas;
   dojis_funcao = contadorDojis;
  }

//--- CONTAR AS VELAS DO QUADRANTE ATUAL (PROCEDIMENTO)
void  ContarVelas_QuadranteAtual(int &matrizVerificada[], int &velasVerdes_funcao, int &velasVermelhas_funcao, int  &dojis_funcao)
  {
   int contadorVerdes = 0;
   int contadorVermelhas = 0;
   int contadorDojis = 0;

   for(int i = 0; i < ArraySize(matrizVerificada); i++)
     {
      if(matrizVerificada[i] == 1)
        {
         contadorVerdes++;
        }

      if(matrizVerificada[i] == 2)
        {
         contadorVermelhas++;
        }

      if(matrizVerificada[i] == 0)
        {
         contadorDojis++;
        }
     }

   velasVerdes_funcao = contadorVerdes;
   velasVermelhas_funcao = contadorVermelhas;
   dojis_funcao = contadorDojis;
  }


//--- CONTAR AS 3 PRIMEIRAS VELAS (PROCEDIMENTO)
void  ContarVelas_Variavel3Primeiras(int &matrizVerificada[], int &velasVerdes_funcao, int &velasVermelhas_funcao, int  &dojis_funcao)
  {
   int contadorVerdes = 0;
   int contadorVermelhas = 0;
   int contadorDojis = 0;

   for(int i = 0; i <= 2; i++)
     {
      if(matrizVerificada[i] == 1)
        {
         contadorVerdes++;
        }

      if(matrizVerificada[i] == 2)
        {
         contadorVermelhas++;
        }

      if(matrizVerificada[i] == 0)
        {
         contadorDojis++;
        }
     }

   velasVerdes_funcao = contadorVerdes;
   velasVermelhas_funcao = contadorVermelhas;
   dojis_funcao = contadorDojis;
  }

//--- CONTAR AS 3 VELAS DO MEIO (PROCEDIMENTO)
void  ContarVelas_Variavel3Meio(int &matrizVerificada[], int &velasVerdes_funcao, int &velasVermelhas_funcao, int  &dojis_funcao)
  {
   int contadorVerdes = 0;
   int contadorVermelhas = 0;
   int contadorDojis = 0;

   for(int i = 1; i <= 3; i++)
     {
      if(matrizVerificada[i] == 1)
        {
         contadorVerdes++;
        }

      if(matrizVerificada[i] == 2)
        {
         contadorVermelhas++;
        }

      if(matrizVerificada[i] == 0)
        {
         contadorDojis++;
        }
     }

   velasVerdes_funcao = contadorVerdes;
   velasVermelhas_funcao = contadorVermelhas;
   dojis_funcao = contadorDojis;
  }

//--- CONTAR AS 3 VELAS DO MEIO M5 ALT (PROCEDIMENTO)
void  ContarVelas_Variavel3Meio_M5Alt(int &matrizVerificada[], int &velasVerdes_funcao, int &velasVermelhas_funcao, int  &dojis_funcao)
  {
   int contadorVerdes = 0;
   int contadorVermelhas = 0;
   int contadorDojis = 0;

   for(int i = 2; i <= 4; i++)
     {
      if(matrizVerificada[i] == 1)
        {
         contadorVerdes++;
        }

      if(matrizVerificada[i] == 2)
        {
         contadorVermelhas++;
        }

      if(matrizVerificada[i] == 0)
        {
         contadorDojis++;
        }
     }

   velasVerdes_funcao = contadorVerdes;
   velasVermelhas_funcao = contadorVermelhas;
   dojis_funcao = contadorDojis;
  }

//--- PREENCHER QUADRANTES
//--- Inteiro (M1)
void  PreencherQuadrante_InteiroM1(int  numeroLinhas_funcao, int   velasPor_quadranteFuncao, int  &vetorOriginal_funcao[], int  &quadranteVelas_funcao[][5])
  {
   int   indiceVelas = 0;
   ArrayResize(quadranteVelas_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(quadranteVelas_funcao);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < velasPor_quadranteFuncao; coluna++)
        {
         quadranteVelas_funcao[linha][coluna] = vetorOriginal_funcao[indiceVelas];
         indiceVelas++;
        }
     }
  }

//--- Inteiro (M5)
void  PreencherQuadrante_InteiroM5(int  numeroLinhas_funcao, int   velasPor_quadranteFuncao, int  &vetorOriginal_funcao[], int  &quadranteVelas_funcao[][6])
  {
   int   indiceVelas = 0;
   ZeroMemory(quadranteVelas_funcao);
   ArrayResize(quadranteVelas_funcao,numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < velasPor_quadranteFuncao; coluna++)
        {
         quadranteVelas_funcao[linha][coluna] = vetorOriginal_funcao[indiceVelas];
         indiceVelas++;
        }
     }
  }

//--- Inteiro (M15)
void  PreencherQuadrante_InteiroM15(int  numeroLinhas_funcao, int   velasPor_quadranteFuncao, int  &vetorOriginal_funcao[], int  &quadranteVelas_funcao[][4])
  {
   int   indiceVelas = 0;
   ZeroMemory(quadranteVelas_funcao);
   ArrayResize(quadranteVelas_funcao, numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < velasPor_quadranteFuncao; coluna++)
        {
         quadranteVelas_funcao[linha][coluna] = vetorOriginal_funcao[indiceVelas];
         indiceVelas++;
        }
     }
  }

//--- Data (M1)
void  PreencherQuadrante_DataM1(int  numeroLinhas_funcao, int   velasPor_quadranteFuncao, MqlRates  &dadosVelas_funcao[], datetime  &quadranteVelas_funcao[][5])
  {
   int   indiceVelas = 0;
   ZeroMemory(quadranteVelas_funcao);
   ArrayResize(quadranteVelas_funcao, numeroLinhas_funcao,0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < velasPor_quadranteFuncao; coluna++)
        {
         quadranteVelas_funcao[linha][coluna] = dadosVelas_funcao[indiceVelas].time;
         indiceVelas++;
        }
     }
  }

//--- Data (M5)
void  PreencherQuadrante_DataM5(int  numeroLinhas_funcao, int   velasPor_quadranteFuncao, MqlRates  &dadosVelas_funcao[], datetime  &quadranteVelas_funcao[][6])
  {
   int   indiceVelas = 0;
   ZeroMemory(quadranteVelas_funcao);
   ArrayResize(quadranteVelas_funcao, numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < velasPor_quadranteFuncao; coluna++)
        {
         quadranteVelas_funcao[linha][coluna] = dadosVelas_funcao[indiceVelas].time;
         indiceVelas++;
        }
     }

  }

//--- Data (M15)
void  PreencherQuadrante_DataM15(int  numeroLinhas_funcao, int   velasPor_quadranteFuncao, MqlRates  &dadosVelas_funcao[], datetime  &quadranteVelas_funcao[][4])
  {
   int   indiceVelas = 0;
   ZeroMemory(quadranteVelas_funcao);
   ArrayResize(quadranteVelas_funcao, numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < velasPor_quadranteFuncao; coluna++)
        {
         quadranteVelas_funcao[linha][coluna] = dadosVelas_funcao[indiceVelas].time;
         indiceVelas++;
        }
     }
  }

//--- CONTAR TIPOS DE VELAS POR QUADRANTE
void  ContarVelas_QuadranteM1(int numeroLinhas_funcao, int velasPor_quadranteFuncao, int   &matrizOriginal_funcao[][5], int  &velasVerdes_quadranteFuncao[], int  &velasVermelhas_quadranteFuncao[], int  &dojisQuadrante_funcao[])
  {
   int   contadorVelas_verdesQuadrante = 0;
   int   contadorVelas_vermelhasQuadrante = 0;
   int   contadorVelas_dojiQuadrante = 0;
   ZeroMemory(velasVerdes_quadranteFuncao);
   ZeroMemory(velasVermelhas_quadranteFuncao);
   ZeroMemory(dojisQuadrante_funcao);
   ArrayResize(velasVerdes_quadranteFuncao, numeroLinhas_funcao, 0);
   ArrayResize(velasVermelhas_quadranteFuncao, numeroLinhas_funcao, 0);
   ArrayResize(dojisQuadrante_funcao, numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < 5; coluna++)
        {
         if(matrizOriginal_funcao[linha][coluna] == 1)
           {
            contadorVelas_verdesQuadrante++;
           }
         else
            if(matrizOriginal_funcao[linha][coluna] == 2)
              {
               contadorVelas_vermelhasQuadrante++;
              }
            else
               if(matrizOriginal_funcao[linha][coluna] == 0)
                 {
                  contadorVelas_dojiQuadrante++;
                 }
        }
      velasVerdes_quadranteFuncao[linha] = contadorVelas_verdesQuadrante;
      velasVermelhas_quadranteFuncao[linha] = contadorVelas_vermelhasQuadrante;
      dojisQuadrante_funcao[linha] = contadorVelas_dojiQuadrante;
      contadorVelas_verdesQuadrante = 0;
      contadorVelas_vermelhasQuadrante = 0;
      contadorVelas_dojiQuadrante = 0;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  ContarVelas_QuadranteM5(int numeroLinhas_funcao, int velasPor_quadranteFuncao, int   &matrizOriginal_funcao[][6], int  &velasVerdes_quadranteFuncao[], int  &velasVermelhas_quadranteFuncao[], int  &dojisQuadrante_funcao[])
  {
   int   contadorVelas_verdesQuadrante = 0;
   int   contadorVelas_vermelhasQuadrante = 0;
   int   contadorVelas_dojiQuadrante = 0;
   ZeroMemory(velasVerdes_quadranteFuncao);
   ZeroMemory(velasVermelhas_quadranteFuncao);
   ZeroMemory(dojisQuadrante_funcao);
   ArrayResize(velasVerdes_quadranteFuncao, numeroLinhas_funcao, 0);
   ArrayResize(velasVermelhas_quadranteFuncao, numeroLinhas_funcao, 0);
   ArrayResize(dojisQuadrante_funcao, numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < 6; coluna++)
        {
         if(matrizOriginal_funcao[linha][coluna] == 1)
           {
            contadorVelas_verdesQuadrante++;
           }
         else
            if(matrizOriginal_funcao[linha][coluna] == 2)
              {
               contadorVelas_vermelhasQuadrante++;
              }
            else
               if(matrizOriginal_funcao[linha][coluna] == 0)
                 {
                  contadorVelas_dojiQuadrante++;
                 }
        }
      velasVerdes_quadranteFuncao[linha] = contadorVelas_verdesQuadrante;
      velasVermelhas_quadranteFuncao[linha] = contadorVelas_vermelhasQuadrante;
      dojisQuadrante_funcao[linha] = contadorVelas_dojiQuadrante;
      contadorVelas_verdesQuadrante = 0;
      contadorVelas_vermelhasQuadrante = 0;
      contadorVelas_dojiQuadrante = 0;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  ContarVelas_QuadranteM15(int numeroLinhas_funcao, int velasPor_quadranteFuncao, int   &matrizOriginal_funcao[][4], int  &velasVerdes_quadranteFuncao[], int  &velasVermelhas_quadranteFuncao[], int  &dojisQuadrante_funcao[])
  {
   int   contadorVelas_verdesQuadrante = 0;
   int   contadorVelas_vermelhasQuadrante = 0;
   int   contadorVelas_dojiQuadrante = 0;
   ArrayResize(velasVerdes_quadranteFuncao, numeroLinhas_funcao, 0);
   ArrayResize(velasVermelhas_quadranteFuncao, numeroLinhas_funcao, 0);
   ArrayResize(dojisQuadrante_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(velasVerdes_quadranteFuncao);
   ZeroMemory(velasVermelhas_quadranteFuncao);
   ZeroMemory(dojisQuadrante_funcao);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < 4; coluna++)
        {
         if(matrizOriginal_funcao[linha][coluna] == 1)
           {
            contadorVelas_verdesQuadrante++;
           }
         else
            if(matrizOriginal_funcao[linha][coluna] == 2)
              {
               contadorVelas_vermelhasQuadrante++;
              }
            else
               if(matrizOriginal_funcao[linha][coluna] == 0)
                 {
                  contadorVelas_dojiQuadrante++;
                 }
        }
      velasVerdes_quadranteFuncao[linha] = contadorVelas_verdesQuadrante;
      velasVermelhas_quadranteFuncao[linha] = contadorVelas_vermelhasQuadrante;
      dojisQuadrante_funcao[linha] = contadorVelas_dojiQuadrante;
      contadorVelas_verdesQuadrante = 0;
      contadorVelas_vermelhasQuadrante = 0;
      contadorVelas_dojiQuadrante = 0;
     }
  }

//--- CONTAR TIPOS DE VELAS POR GRUPOS DE TRÊS
void  ContarVelas_GrupoTres(int numeroLinhas_funcao, int velasPor_grupo3Funcao, int   &matrizOriginal_funcao[][3], int  &velasVerdes_grupo3Funcao[], int  &velasVermelhas_grupo3Funcao[], int  &dojisQuadrante_funcao[])
  {
   int   contadorVelas_verdesGrupo3 = 0;
   int   contadorVelas_vermelhasGrupo3 = 0;
   int   contadorVelas_dojiQuadrante = 0;
   ZeroMemory(velasVerdes_grupo3Funcao);
   ZeroMemory(velasVermelhas_grupo3Funcao);
   ZeroMemory(dojisQuadrante_funcao);
   ArrayResize(velasVerdes_grupo3Funcao, numeroLinhas_funcao, 0);
   ArrayResize(velasVermelhas_grupo3Funcao, numeroLinhas_funcao, 0);
   ArrayResize(dojisQuadrante_funcao, numeroLinhas_funcao, 0);

   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      for(int coluna = 0; coluna < 3; coluna++)
        {
         if(matrizOriginal_funcao[linha][coluna] == 1)
           {
            contadorVelas_verdesGrupo3++;
           }
         else
            if(matrizOriginal_funcao[linha][coluna] == 2)
              {
               contadorVelas_vermelhasGrupo3++;
              }
            else
               if(matrizOriginal_funcao[linha][coluna] == 0)
                 {
                  contadorVelas_dojiQuadrante++;
                 }
        }
      velasVerdes_grupo3Funcao[linha] = contadorVelas_verdesGrupo3;
      velasVermelhas_grupo3Funcao[linha] = contadorVelas_vermelhasGrupo3;
      dojisQuadrante_funcao[linha] = contadorVelas_dojiQuadrante;
      contadorVelas_verdesGrupo3 = 0;
      contadorVelas_vermelhasGrupo3 = 0;
      contadorVelas_dojiQuadrante = 0;
     }
  }

//--- Calcular Maiorias (M1)
void  CalcularMaioria_M1(int numeroLinhas_funcao, string &maioriaVelas_funcao[][2], datetime  &periodoVelas_quadranteFuncao[][5], int   &velasVerdes_quadranteFuncao[], int  &velasVermelhas_quadranteFuncao[], int colunaInicio_matrizFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      maioriaVelas_funcao[linha][0] = TimeToString(periodoVelas_quadranteFuncao[linha][colunaInicio_matrizFuncao]);
      if(velasVerdes_quadranteFuncao[linha] > velasVermelhas_quadranteFuncao[linha])
        {
         maioriaVelas_funcao[linha][1] = "1";
        }
      else
         if(velasVerdes_quadranteFuncao[linha] < velasVermelhas_quadranteFuncao[linha])
           {
            maioriaVelas_funcao[linha][1] = "2";
           }
         else
           {
            maioriaVelas_funcao[linha][1] = "0";
           }
     }
  }

//--- Calcular Maiorias (M5)
void  CalcularMaioria_M5(int numeroLinhas_funcao, string &maioriaVelas_funcao[][2], datetime  &periodoVelas_quadranteFuncao[][6], int   &velasVerdes_quadranteFuncao[], int  &velasVermelhas_quadranteFuncao[], int colunaInicio_matrizFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      maioriaVelas_funcao[linha][0] = TimeToString(periodoVelas_quadranteFuncao[linha][colunaInicio_matrizFuncao]);
      if(velasVerdes_quadranteFuncao[linha] > velasVermelhas_quadranteFuncao[linha])
        {
         maioriaVelas_funcao[linha][1] = "1";
        }
      else
         if(velasVerdes_quadranteFuncao[linha] < velasVermelhas_quadranteFuncao[linha])
           {
            maioriaVelas_funcao[linha][1] = "2";
           }
         else
           {
            maioriaVelas_funcao[linha][1] = "0";
           }
     }
  }

//--- Calcular Maiorias (M15)
void  CalcularMaioria_M15(int numeroLinhas_funcao, string &maioriaVelas_funcao[][2], datetime  &periodoVelas_quadranteFuncao[][4], int   &velasVerdes_quadranteFuncao[], int  &velasVermelhas_quadranteFuncao[], int colunaInicio_matrizFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      maioriaVelas_funcao[linha][0] = TimeToString(periodoVelas_quadranteFuncao[linha][colunaInicio_matrizFuncao]);
      if(velasVerdes_quadranteFuncao[linha] > velasVermelhas_quadranteFuncao[linha])
        {
         maioriaVelas_funcao[linha][1] = "1";
        }
      else
         if(velasVerdes_quadranteFuncao[linha] < velasVermelhas_quadranteFuncao[linha])
           {
            maioriaVelas_funcao[linha][1] = "2";
           }
         else
           {
            maioriaVelas_funcao[linha][1] = "0";
           }
     }
  }

//--- Calcular Maiorias (Quadrante Atual)
void  CalcularMaioria_QuadranteAtual(int numeroLinhas_funcao, int &maioriaVelas_atualFuncao, int   velasVerdes_atualFuncao, int  velasVermelhas_atualFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      if(velasVerdes_atualFuncao > velasVermelhas_atualFuncao)
        {
         maioriaVelas_atualFuncao = 1;
        }
      else
         if(velasVerdes_atualFuncao < velasVermelhas_atualFuncao)
           {
            maioriaVelas_atualFuncao = 2;
           }
         else
           {
            maioriaVelas_atualFuncao = 0;
           }
     }
  }
//+------------------------------------------------------------------+

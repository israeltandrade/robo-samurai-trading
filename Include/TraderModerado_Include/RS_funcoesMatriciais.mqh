//+------------------------------------------------------------------+
//|                                         ES_funcoesMatriciais.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"

//--- Preparar Vetor Inteiro (PROCEDIMENTO)
void  PrepararVetor_Inteiro(int   numeroLinhas_funcao, int   &vetorAlvo_funcao[])
  {
   ZeroMemory(vetorAlvo_funcao);
   ArrayResize(vetorAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(vetorAlvo_funcao);
  }

//--- Preparar Vetor String (PROCEDIMENTO)
void  PrepararVetor_String(int   numeroLinhas_funcao, string   &vetorAlvo_funcao[])
  {
   ZeroMemory(vetorAlvo_funcao);
   ArrayResize(vetorAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(vetorAlvo_funcao);
  }

//--- Preparar Vetor Double (PROCEDIMENTO)
void  PrepararVetor_Double(int   numeroLinhas_funcao, double   &vetorAlvo_funcao[])
  {
   ZeroMemory(vetorAlvo_funcao);
   ArrayResize(vetorAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(vetorAlvo_funcao);
  }

//--- Preparar Vetor Datetime (PROCEDIMENTO)
void  PrepararVetor_Datetime(int   numeroLinhas_funcao, datetime   &vetorAlvo_funcao[])
  {
   ZeroMemory(vetorAlvo_funcao);
   ArrayResize(vetorAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(vetorAlvo_funcao);
  }

//--- Preparar Matriz de Duas Colunas do Tipo String (PROCEDIMENTO)
void  PrepararMatriz_StringDois(int   numeroLinhas_funcao, string   &matrizAlvo_funcao[][2])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- Preparar Matriz de Duas Colunas do Tipo Double (PROCEDIMENTO)
void  PrepararMatriz_DoubleDois(int   numeroLinhas_funcao, double   &matrizAlvo_funcao[][2])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- Preparar Matriz de Três Colunas (PROCEDIMENTO)
void  PrepararMatriz_InteiroTres(int   numeroLinhas_funcao, int   &matrizAlvo_funcao[][3])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- PREPARAR MATRIZ DE 3 COLUNAS - STRING (PROCEDIMENTO)
void  PrepararMatriz_StringTres(int   numeroLinhas_funcao, string   &matrizAlvo_funcao[][3])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- PREPARAR MATRIZ DE 4 COLUNAS - STRING (PROCEDIMENTO)
void  PrepararMatriz_StringQuatro(int   numeroLinhas_funcao, string   &matrizAlvo_funcao[][4])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- PREPARAR MATRIZ DE 5 COLUNAS - STRING (PROCEDIMENTO)
void  PrepararMatriz_StringCinco(int   numeroLinhas_funcao, string   &matrizAlvo_funcao[][5])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- PREPARAR MATRIZ DE 6 COLUNAS - STRING (PROCEDIMENTO)
void  PrepararMatriz_StringSeis(int   numeroLinhas_funcao, string   &matrizAlvo_funcao[][6])
  {
   ZeroMemory(matrizAlvo_funcao);
   ArrayResize(matrizAlvo_funcao, numeroLinhas_funcao, 0);
   ZeroMemory(matrizAlvo_funcao);
  }

//--- COPIAR VETOR STRING (PROCEDIMENTO)
void  CopiarVetor_String(string &matrizDestino_funcao[], string &matrizFonte_funcao[])
  {
   ZeroMemory(matrizDestino_funcao);
   ArrayResize(matrizDestino_funcao, ArraySize(matrizFonte_funcao), 0);
   ArrayCopy(matrizDestino_funcao, matrizFonte_funcao, 0, 0, WHOLE_ARRAY);
  }

//--- COPIAR VETOR INTEIRO (PROCEDIMENTO)
void  CopiarVetor_Inteiro(int &matrizDestino_funcao[], int &matrizFonte_funcao[])
  {
   ZeroMemory(matrizDestino_funcao);
   ArrayResize(matrizDestino_funcao, ArraySize(matrizFonte_funcao), 0);
   ArrayCopy(matrizDestino_funcao, matrizFonte_funcao, 0, 0, WHOLE_ARRAY);
  }

//--- COPIAR 1ª COLUNA DE MATRIZ DE 4 COLUNAS PARA VETOR
void  CopiarMatriz4_DatetimeVetor1_String(string   &vetorDestino_funcao[], datetime &matrizFonte_funcao[][4])
  {
   ZeroMemory(vetorDestino_funcao);
   ArrayResize(vetorDestino_funcao, ArrayRange(matrizFonte_funcao, 0));
   ZeroMemory(vetorDestino_funcao);

   for(int i = 0; i < ArrayRange(matrizFonte_funcao, 0); i++)
     {
      vetorDestino_funcao[i] = TimeToString(matrizFonte_funcao[i][0]);
     }
  }

//--- COPIAR 1ª COLUNA DE MATRIZ DE 5 COLUNAS PARA VETOR
void  CopiarMatriz5_DatetimeVetor1_String(string   &vetorDestino_funcao[], datetime &matrizFonte_funcao[][5])
  {
   ZeroMemory(vetorDestino_funcao);
   ArrayResize(vetorDestino_funcao, ArrayRange(matrizFonte_funcao, 0));
   ZeroMemory(vetorDestino_funcao);

   for(int i = 0; i < ArrayRange(matrizFonte_funcao, 0); i++)
     {
      vetorDestino_funcao[i] = TimeToString(matrizFonte_funcao[i][0]);
     }
  }

//--- COPIAR 1ª COLUNA DE MATRIZ DE 6 COLUNAS PARA VETOR
void  CopiarMatriz6_DatetimeVetor1_String(string   &vetorDestino_funcao[], datetime &matrizFonte_funcao[][6])
  {
   ZeroMemory(vetorDestino_funcao);
   ArrayResize(vetorDestino_funcao, ArrayRange(matrizFonte_funcao, 0));
   ZeroMemory(vetorDestino_funcao);

   for(int i = 0; i < ArrayRange(matrizFonte_funcao, 0); i++)
     {
      vetorDestino_funcao[i] = TimeToString(matrizFonte_funcao[i][0]);
     }
  }

//--- COPIAR 3 ITENS DA MATRIZ (PROCEDIMENTO)
void  CopiarMatriz_QuatroTres(int numeroLinhas_funcao, int   &matrizDestino_funcao[][3], int &matrizFonte_funcao[][4], int  deslocamentoFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      matrizDestino_funcao[linha][0] = matrizFonte_funcao[linha][0 + deslocamentoFuncao];
      matrizDestino_funcao[linha][1] = matrizFonte_funcao[linha][1 + deslocamentoFuncao];
      matrizDestino_funcao[linha][2] = matrizFonte_funcao[linha][2 + deslocamentoFuncao];
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  CopiarMatriz_CincoTres(int numeroLinhas_funcao, int   &matrizDestino_funcao[][3], int &matrizFonte_funcao[][5], int  deslocamentoFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      matrizDestino_funcao[linha][0] = matrizFonte_funcao[linha][0 + deslocamentoFuncao];
      matrizDestino_funcao[linha][1] = matrizFonte_funcao[linha][1 + deslocamentoFuncao];
      matrizDestino_funcao[linha][2] = matrizFonte_funcao[linha][2 + deslocamentoFuncao];
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  CopiarMatriz_SeisTres(int numeroLinhas_funcao, int   &matrizDestino_funcao[][3], int &matrizFonte_funcao[][6], int  deslocamentoFuncao)
  {
   for(int linha = 0; linha < numeroLinhas_funcao; linha++)
     {
      matrizDestino_funcao[linha][0] = matrizFonte_funcao[linha][0 + deslocamentoFuncao];
      matrizDestino_funcao[linha][1] = matrizFonte_funcao[linha][1 + deslocamentoFuncao];
      matrizDestino_funcao[linha][2] = matrizFonte_funcao[linha][2 + deslocamentoFuncao];
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  Zerar15Matrizes(int &primeira, int   &segunda, int  &terceira, int  &quarta, int  &quinta, int  &sexta, int  &setima, int  &oitava, int  &nona, int  &decima, int  &decimaPrimeira, int  &decimaSegunda, int  &decimaTerceira, int  &decimaQuarta, int  &decimaQuinta)
  {
   ZeroMemory(primeira);
   ZeroMemory(segunda);
   ZeroMemory(terceira);
   ZeroMemory(quarta);
   ZeroMemory(quinta);
   ZeroMemory(sexta);
   ZeroMemory(setima);
   ZeroMemory(oitava);
   ZeroMemory(nona);
   ZeroMemory(decima);
   ZeroMemory(decimaPrimeira);
   ZeroMemory(decimaSegunda);
   ZeroMemory(decimaTerceira);
   ZeroMemory(decimaQuarta);
   ZeroMemory(decimaQuinta);
  }

//---CONTATENAR MATRIZES STRING PDR (FUNÇÃO)
string   ConcatenarMatriz_StringPDR(int  numeroLinhas_funcao, string &matrizOriginal_funcao[][2])
  {
   string   matrizConcatenada_funcao = "";

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      matrizConcatenada_funcao += matrizOriginal_funcao[i][1];
     }

   StringReplace(matrizConcatenada_funcao, "INV", "OSS");
   StringReplace(matrizConcatenada_funcao, "SEM", "");
   StringReplace(matrizConcatenada_funcao, "DOJ", "");

   return   matrizConcatenada_funcao;
  }

//---CONTATENAR MATRIZES STRING INV (FUNÇÃO)
string   ConcatenarMatriz_StringINV(int  numeroLinhas_funcao, string &matrizOriginal_funcao[][2])
  {
   string   matrizConcatenada_funcao = "";

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      matrizConcatenada_funcao += matrizOriginal_funcao[i][1];
     }

   StringReplace(matrizConcatenada_funcao, "PDR", "OSS");
   StringReplace(matrizConcatenada_funcao, "SEM", "");
   StringReplace(matrizConcatenada_funcao, "DOJ", "");

   return   matrizConcatenada_funcao;
  }

//--- CONCATENAR LOSS EM KATANÁ
string   ConcatenarLoss_Katana(int  katanaBarreira_funcao)
  {
   string   katanaLoss_concatenadoFuncao;

   for(int i = 0; i < katanaBarreira_funcao; i++)
     {
      katanaLoss_concatenadoFuncao += "OSS";
     }

   return katanaLoss_concatenadoFuncao;
  }

//--- REVERSÃO DA 1ª COLUNA DA MATRIZ TIPO DOUBLE (PROCEDIMENTO)
void  ReverterMatriz_DoubleColuna1(double  &porcentagemVetor_funcao[], double  &porcentagemMatriz_organizadaFuncao[][2])
  {
   int   comecoClassificacao_primeiraDimensao = 0;

   int   fimClassificacao_primeiraDimensao = ArrayRange(porcentagemVetor_funcao, 0) - 1;

   while(comecoClassificacao_primeiraDimensao < fimClassificacao_primeiraDimensao)
     {
      double   temporario = porcentagemMatriz_organizadaFuncao[comecoClassificacao_primeiraDimensao][0];

      porcentagemVetor_funcao[comecoClassificacao_primeiraDimensao] = porcentagemMatriz_organizadaFuncao[fimClassificacao_primeiraDimensao][0];

      porcentagemVetor_funcao[fimClassificacao_primeiraDimensao] = temporario;

      comecoClassificacao_primeiraDimensao++;

      fimClassificacao_primeiraDimensao--;
     }
  }

//--- REVERSÃO DA 2ª COLUNA DA MATRIZ TIPO DOUBLE (PROCEDIMENTO)
void  ReverterMatriz_DoubleColuna2(double  &porcentagemVetor_funcao[], double  &porcentagemMatriz_organizadaFuncao[][2])
  {
   int   comecoClassificacao_primeiraDimensao = 0;

   int   fimClassificacao_primeiraDimensao = ArrayRange(porcentagemVetor_funcao, 0) - 1;

   while(comecoClassificacao_primeiraDimensao < fimClassificacao_primeiraDimensao)
     {
      double   temporario = porcentagemMatriz_organizadaFuncao[comecoClassificacao_primeiraDimensao][1];

      porcentagemVetor_funcao[comecoClassificacao_primeiraDimensao] = porcentagemMatriz_organizadaFuncao[fimClassificacao_primeiraDimensao][1];

      porcentagemVetor_funcao[fimClassificacao_primeiraDimensao] = temporario;

      comecoClassificacao_primeiraDimensao++;

      fimClassificacao_primeiraDimensao--;
     }
  }

//--- AVANÇAR OS INDICES DO PAINEL
void  AvancarIndices(int  limiteIndice_funcao, int diferencaIndice_funcao, int &indiceMaximo_funcao, int &indiceMinimo_funcao)
  {
   indiceMaximo_funcao = indiceMaximo_funcao + diferencaIndice_funcao;
   indiceMinimo_funcao = indiceMaximo_funcao - diferencaIndice_funcao;

   if(indiceMaximo_funcao > limiteIndice_funcao)
     {
      indiceMaximo_funcao = limiteIndice_funcao;
     }

   if(indiceMinimo_funcao > limiteIndice_funcao)
     {
      indiceMinimo_funcao = limiteIndice_funcao - diferencaIndice_funcao;
     }

   if(indiceMinimo_funcao == indiceMaximo_funcao && indiceMaximo_funcao >= diferencaIndice_funcao)
     {
      indiceMinimo_funcao = indiceMaximo_funcao - diferencaIndice_funcao;
     }

   if(indiceMinimo_funcao < 0)
     {
      indiceMinimo_funcao = 0;
     }
  }

//--- RECUAR OS INDICES DO PAINEL
void  RecuarIndices(int  limiteIndice_funcao, int diferencaIndice_funcao, int &indiceMaximo_funcao, int &indiceMinimo_funcao)
  {
   indiceMinimo_funcao = indiceMinimo_funcao - diferencaIndice_funcao;
   indiceMaximo_funcao = indiceMinimo_funcao + diferencaIndice_funcao;


   if(indiceMaximo_funcao < diferencaIndice_funcao)
     {
      indiceMaximo_funcao = diferencaIndice_funcao;
     }

   if(indiceMaximo_funcao > limiteIndice_funcao)
     {
      indiceMaximo_funcao = limiteIndice_funcao;
     }

   if(indiceMaximo_funcao < 0)
     {
      indiceMaximo_funcao = 0;
     }



   if(indiceMinimo_funcao > limiteIndice_funcao)
     {
      indiceMinimo_funcao = limiteIndice_funcao - diferencaIndice_funcao;
     }

   if(indiceMinimo_funcao < 0)
     {
      indiceMinimo_funcao = 0;
     }
  }

//--- PULAR PARA O FINAL DOS INDICES DO PAINEL
void  FinalIndices(int  limiteIndice_funcao, int diferencaIndice_funcao, int &indiceMaximo_funcao, int &indiceMinimo_funcao)
  {
   indiceMaximo_funcao = limiteIndice_funcao;
   indiceMinimo_funcao = indiceMaximo_funcao - diferencaIndice_funcao;

   if(indiceMinimo_funcao < 0)
     {
      indiceMinimo_funcao = 0;
     }
  }

//--- PULAR PARA O INÍCIO DOS INDICES DO PAINEL
void  InicioIndices(int  limiteIndice_funcao, int diferencaIndice_funcao, int &indiceMaximo_funcao, int &indiceMinimo_funcao)
  {
   indiceMinimo_funcao = 0;
   indiceMaximo_funcao = indiceMinimo_funcao + diferencaIndice_funcao;

   if(indiceMaximo_funcao > limiteIndice_funcao)
     {
      indiceMaximo_funcao = limiteIndice_funcao;
     }
  }

//--- ORGANIZAR (SORT) MqlRates PELA DATA
void  OrganizarEstrutura_RatesTime (MqlRates &estruturaRates[])
{
   MqlRates   temp[1];
   
   for(int i = 0; i < ArrayRange(estruturaRates, 0) - 1; i++)
     {
      for(int j = 0; j < ArrayRange(estruturaRates, 0) - i -1; j++)
        {
         if(estruturaRates[j].time > estruturaRates[j + 1].time)
           {
            temp[0] = estruturaRates[j];
            estruturaRates[j] = estruturaRates[j + 1];
            estruturaRates[j + 1] = temp[0];
           }
        }
     }
}
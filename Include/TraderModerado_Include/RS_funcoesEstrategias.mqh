//+------------------------------------------------------------------+
//|                                        ES_funcoesEstrategias.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"

//--- Estratégias de Fluxo (M1 PDR)
void  PreencherQuadrante_EstrategiaFluxo_PDRM1(int  numeroLinhas_funcao, datetime   &quadrantePeriodo_funcao[][5], int &quadranteVelas_funcao[][5], int  deslocamentoFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && deslocamentoFuncao == 4)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && deslocamentoFuncao != 4)
        {
         deslocamentoFinal = deslocamentoFuncao + 1;
        }

   if(posicoesFuncao == 2 && deslocamentoFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && deslocamentoFuncao == 4)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = deslocamentoFuncao + 1;
            deslocamentoFinal2 = deslocamentoFuncao + 2;
           }

   if(posicoesFuncao == 3 && deslocamentoFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 4;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && deslocamentoFuncao == 3)
        {
         deslocamentoFinal = 4;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && deslocamentoFuncao == 4)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = deslocamentoFuncao + 1;
               deslocamentoFinal2 = deslocamentoFuncao + 2;
               deslocamentoFinal3 = deslocamentoFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 4)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 3)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 2)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && deslocamentoFuncao == 4)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = TimeToString(quadrantePeriodo_funcao[i][deslocamentoFuncao]);

      if(posicoesFuncao == 1)
        {
         if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
           {
            matrizEstrategia_funcao[i][1] = "DOJ";
           }
         else
            if(quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[i][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && (j + 1) < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == 0 && j + 2 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i]
                        [1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && (j + 2) < numeroLinhas_funcao)
                    {
                     if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                       {
                        matrizEstrategia_funcao[i][1] = "DOJ";
                       }
                     else
                        if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == 0 && j + 3 < numeroLinhas_funcao &&
                            quadranteVelas_funcao[i + 3][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 3][deslocamentoFuncao] == quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "PDR";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }

              }
     }
  }


//--- Estratégias de Fluxo (M1 INV)
void  PreencherQuadrante_EstrategiaFluxo_INVM1(int  numeroLinhas_funcao, datetime   &quadrantePeriodo_funcao[][5], int &quadranteVelas_funcao[][5], int  deslocamentoFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && deslocamentoFuncao == 4)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && deslocamentoFuncao != 4)
        {
         deslocamentoFinal = deslocamentoFuncao + 1;
        }

   if(posicoesFuncao == 2 && deslocamentoFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && deslocamentoFuncao == 4)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = deslocamentoFuncao + 1;
            deslocamentoFinal2 = deslocamentoFuncao + 2;
           }

   if(posicoesFuncao == 3 && deslocamentoFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 4;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && deslocamentoFuncao == 3)
        {
         deslocamentoFinal = 4;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && deslocamentoFuncao == 4)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = deslocamentoFuncao + 1;
               deslocamentoFinal2 = deslocamentoFuncao + 2;
               deslocamentoFinal3 = deslocamentoFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 4)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 3)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 2)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && deslocamentoFuncao == 4)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = TimeToString(quadrantePeriodo_funcao[i][deslocamentoFuncao]);

      if(posicoesFuncao == 1)
        {
         if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
           {
            matrizEstrategia_funcao[i][1] = "DOJ";
           }
         else
            if(quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[i][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && (j + 1) < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == 0 && j + 2 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && (j + 2) < numeroLinhas_funcao)
                    {
                     if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                       {
                        matrizEstrategia_funcao[i][1] = "DOJ";
                       }
                     else
                        if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == 0 && j + 3 < numeroLinhas_funcao &&
                            quadranteVelas_funcao[i + 3][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 3][deslocamentoFuncao] != quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "INV";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }


//--- Estratégias de Fluxo (M5 PDR)
void  PreencherQuadrante_EstrategiaFluxo_PDRM5(int  numeroLinhas_funcao, datetime   &quadrantePeriodo_funcao[][6], int &quadranteVelas_funcao[][6], int  deslocamentoFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && deslocamentoFuncao == 5)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && deslocamentoFuncao != 5)
        {
         deslocamentoFinal = deslocamentoFuncao + 1;
        }

   if(posicoesFuncao == 2 && deslocamentoFuncao == 4)
     {
      deslocamentoFinal = 5;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && deslocamentoFuncao == 5)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = deslocamentoFuncao + 1;
            deslocamentoFinal2 = deslocamentoFuncao + 2;
           }

   if(posicoesFuncao == 3 && deslocamentoFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 5;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && deslocamentoFuncao == 4)
        {
         deslocamentoFinal = 5;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && deslocamentoFuncao == 5)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = deslocamentoFuncao + 1;
               deslocamentoFinal2 = deslocamentoFuncao + 2;
               deslocamentoFinal3 = deslocamentoFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 5)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 4)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 3)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && deslocamentoFuncao == 5)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = TimeToString(quadrantePeriodo_funcao[i][deslocamentoFuncao]);

      if(posicoesFuncao == 1)
        {
         if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
           {
            matrizEstrategia_funcao[i][1] = "DOJ";
           }
         else
            if(quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[i][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == 0 && j + 2 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == 0 && j + 3 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 3][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 3][deslocamentoFuncao] == quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                       {
                        matrizEstrategia_funcao[i][1] = "DOJ";
                       }
                     else
                        if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "PDR";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }


//--- Estratégias de Fluxo (M5 INV)
void  PreencherQuadrante_EstrategiaFluxo_INVM5(int  numeroLinhas_funcao, datetime   &quadrantePeriodo_funcao[][6], int &quadranteVelas_funcao[][6], int  deslocamentoFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && deslocamentoFuncao == 5)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && deslocamentoFuncao != 5)
        {
         deslocamentoFinal = deslocamentoFuncao + 1;
        }

   if(posicoesFuncao == 2 && deslocamentoFuncao == 4)
     {
      deslocamentoFinal = 5;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && deslocamentoFuncao == 5)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = deslocamentoFuncao + 1;
            deslocamentoFinal2 = deslocamentoFuncao + 2;
           }

   if(posicoesFuncao == 3 && deslocamentoFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 5;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && deslocamentoFuncao == 4)
        {
         deslocamentoFinal = 5;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && deslocamentoFuncao == 5)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = deslocamentoFuncao + 1;
               deslocamentoFinal2 = deslocamentoFuncao + 2;
               deslocamentoFinal3 = deslocamentoFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 5)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 4)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 3)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && deslocamentoFuncao == 5)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = TimeToString(quadrantePeriodo_funcao[i][deslocamentoFuncao]);

      if(posicoesFuncao == 1)
        {
         if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
           {
            matrizEstrategia_funcao[i][1] = "DOJ";
           }
         else
            if(quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[i][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == 0 && j + 2 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                       {
                        matrizEstrategia_funcao[i][1] = "DOJ";
                       }
                     else
                        if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == 0 && j + 3 < numeroLinhas_funcao &&
                            quadranteVelas_funcao[i + 3][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 3][deslocamentoFuncao] != quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "INV";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Fluxo (M15 PDR)
void  PreencherQuadrante_EstrategiaFluxo_PDRM15(int  numeroLinhas_funcao, datetime   &quadrantePeriodo_funcao[][4], int &quadranteVelas_funcao[][4], int  deslocamentoFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && deslocamentoFuncao == 3)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && deslocamentoFuncao != 3)
        {
         deslocamentoFinal = deslocamentoFuncao + 1;
        }

   if(posicoesFuncao == 2 && deslocamentoFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && deslocamentoFuncao == 3)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = deslocamentoFuncao + 1;
            deslocamentoFinal2 = deslocamentoFuncao + 2;
           }

   if(posicoesFuncao == 3 && deslocamentoFuncao == 1)
     {
      deslocamentoFinal = 2;
      deslocamentoFinal2 = 3;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && deslocamentoFuncao == 2)
        {
         deslocamentoFinal = 3;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && deslocamentoFuncao == 3)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = deslocamentoFuncao + 1;
               deslocamentoFinal2 = deslocamentoFuncao + 2;
               deslocamentoFinal3 = deslocamentoFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 3)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 2)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }

      if(metodoPosicoes_funcao == 2 && deslocamentoFuncao == 3)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = TimeToString(quadrantePeriodo_funcao[i][deslocamentoFuncao]);

      if(posicoesFuncao == 1)
        {
         if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
           {
            matrizEstrategia_funcao[i][1] = "DOJ";
           }
         else
            if(quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[i][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == 0 && j + 2 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                       {
                        matrizEstrategia_funcao[i][1] = "DOJ";
                       }
                     else
                        if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == 0 && j + 3 < numeroLinhas_funcao &&
                            quadranteVelas_funcao[i + 3][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 3][deslocamentoFuncao] == quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "PDR";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Fluxo (M15 INV)
void  PreencherQuadrante_EstrategiaFluxo_INVM15(int  numeroLinhas_funcao, datetime   &quadrantePeriodo_funcao[][4], int &quadranteVelas_funcao[][4], int  deslocamentoFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && deslocamentoFuncao == 3)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && deslocamentoFuncao != 3)
        {
         deslocamentoFinal = deslocamentoFuncao + 1;
        }

   if(posicoesFuncao == 2 && deslocamentoFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && deslocamentoFuncao == 3)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = deslocamentoFuncao + 1;
            deslocamentoFinal2 = deslocamentoFuncao + 2;
           }

   if(posicoesFuncao == 3 && deslocamentoFuncao == 1)
     {
      deslocamentoFinal = 2;
      deslocamentoFinal2 = 3;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && deslocamentoFuncao == 2)
        {
         deslocamentoFinal = 3;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && deslocamentoFuncao == 3)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = deslocamentoFuncao + 1;
               deslocamentoFinal2 = deslocamentoFuncao + 2;
               deslocamentoFinal3 = deslocamentoFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 3)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && deslocamentoFuncao == 2)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }

      if(metodoPosicoes_funcao == 2 && deslocamentoFuncao == 3)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = TimeToString(quadrantePeriodo_funcao[i][deslocamentoFuncao]);

      if(posicoesFuncao == 1)
        {
         if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
           {
            matrizEstrategia_funcao[i][1] = "DOJ";
           }
         else
            if(quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[i][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i + 1][deslocamentoFuncao] == 0 && j + 2 < numeroLinhas_funcao &&
                         quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[i][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(quadranteVelas_funcao[i][deslocamentoFuncao] == 0)
                       {
                        matrizEstrategia_funcao[i][1] = "DOJ";
                       }
                     else
                        if((quadranteVelas_funcao[i][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i][deslocamentoFuncao] != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 1][deslocamentoFuncao] != quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 2][deslocamentoFuncao] != quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (quadranteVelas_funcao[i + 2][deslocamentoFuncao] == 0 && j + 3 < numeroLinhas_funcao &&
                            quadranteVelas_funcao[i + 3][deslocamentoFuncao] != 0 && (quadranteVelas_funcao[i + 3][deslocamentoFuncao] != quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "INV";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Maioria (M1 PDR)
void  PreencherQuadrante_EstrategiaMaioria_PDRM1(int  numeroLinhas_funcao, int &quadranteVelas_funcao[][5], string &matrizMaioria_funcao[][2], int ultimaVela_maioriaFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao == 4)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao != 4)
        {
         deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
        }

   if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 4)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
            deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
           }

   if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 4;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 3)
        {
         deslocamentoFinal = 4;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 4)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
               deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
               deslocamentoFinal3 = ultimaVela_maioriaFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 4)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 3)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 2)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && ultimaVela_maioriaFuncao == 4)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = matrizMaioria_funcao[i][0];

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[i][1] == "0")
           {
            matrizEstrategia_funcao[i][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[i][1] != "0" && (StringToInteger(matrizMaioria_funcao[i][1]) == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "PDR";

              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(matrizMaioria_funcao[i][1] == "0")
                 {
                  matrizEstrategia_funcao[i][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] == IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] == "0" && j + 2 < numeroLinhas_funcao &&
                         matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] == IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(matrizMaioria_funcao[i][1] == "0")
                       {
                        matrizEstrategia_funcao[i][1] = "SEM";
                       }
                     else
                        if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] == IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] == IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] == "0" && j + 3 < numeroLinhas_funcao &&
                            matrizMaioria_funcao[i + 3][1] != "0" && matrizMaioria_funcao[i + 3][1] == IntegerToString(quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "PDR";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Maioria (M1 INV)
void  PreencherQuadrante_EstrategiaMaioria_INVM1(int  numeroLinhas_funcao, int &quadranteVelas_funcao[][5], string &matrizMaioria_funcao[][2], int ultimaVela_maioriaFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao == 4)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao != 4)
        {
         deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
        }

   if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 4)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
            deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
           }

   if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 4;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 3)
        {
         deslocamentoFinal = 4;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 4)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
               deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
               deslocamentoFinal3 = ultimaVela_maioriaFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 4)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 3)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 2)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && ultimaVela_maioriaFuncao == 4)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = matrizMaioria_funcao[i][0];

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[i][1] == "0")
           {
            matrizEstrategia_funcao[i][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[i][1] != "0" && (StringToInteger(matrizMaioria_funcao[i][1]) != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "INV";

              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(matrizMaioria_funcao[i][1] == "0")
                 {
                  matrizEstrategia_funcao[i][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] != IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] == "0" && j + 2 < numeroLinhas_funcao &&
                         matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] != IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(matrizMaioria_funcao[i][1] == "0")
                       {
                        matrizEstrategia_funcao[i][1] = "SEM";
                       }
                     else
                        if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] != IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] != IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] == "0" && j + 3 < numeroLinhas_funcao &&
                            matrizMaioria_funcao[i + 3][1] != "0" && matrizMaioria_funcao[i + 3][1] != IntegerToString(quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "INV";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Maioria (M5 PDR)
void  PreencherQuadrante_EstrategiaMaioria_PDRM5(int  numeroLinhas_funcao, int &quadranteVelas_funcao[][6], string &matrizMaioria_funcao[][2], int ultimaVela_maioriaFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao == 5)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao != 5)
        {
         deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
        }

   if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 4)
     {
      deslocamentoFinal = 5;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 5)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
            deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
           }

   if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 5;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 4)
        {
         deslocamentoFinal = 5;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 5)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
               deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
               deslocamentoFinal3 = ultimaVela_maioriaFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 5)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 4)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 3)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && ultimaVela_maioriaFuncao == 5)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = matrizMaioria_funcao[i][0];

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[i][1] == "0")
           {
            matrizEstrategia_funcao[i][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[i][1] != "0" && (StringToInteger(matrizMaioria_funcao[i][1]) == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "PDR";

              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(matrizMaioria_funcao[i][1] == "0")
                 {
                  matrizEstrategia_funcao[i][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] == IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] == "0" && j + 2 < numeroLinhas_funcao &&
                         matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] == IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(matrizMaioria_funcao[i][1] == "0")
                       {
                        matrizEstrategia_funcao[i][1] = "SEM";
                       }
                     else
                        if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] == IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] == IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] == "0" && j + 3 < numeroLinhas_funcao &&
                            matrizMaioria_funcao[i + 3][1] != "0" && matrizMaioria_funcao[i + 3][1] == IntegerToString(quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "PDR";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Maioria (M5 INV)
void  PreencherQuadrante_EstrategiaMaioria_INVM5(int  numeroLinhas_funcao, int &quadranteVelas_funcao[][6], string &matrizMaioria_funcao[][2], int ultimaVela_maioriaFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao == 5)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao != 5)
        {
         deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
        }

   if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 4)
     {
      deslocamentoFinal = 5;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 5)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }
      else
         if(posicoesFuncao == 2)
           {
            deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
            deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
           }

   if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 3)
     {
      deslocamentoFinal = 4;
      deslocamentoFinal2 = 5;
      deslocamentoFinal3 = 0;
     }
   else
      if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 4)
        {
         deslocamentoFinal = 5;
         deslocamentoFinal2 = 0;
         deslocamentoFinal3 = 1;
        }
      else
         if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 5)
           {
            deslocamentoFinal = 0;
            deslocamentoFinal2 = 1;
            deslocamentoFinal3 = 2;
           }
         else
            if(posicoesFuncao == 3)
              {
               deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
               deslocamentoFinal2 = ultimaVela_maioriaFuncao + 2;
               deslocamentoFinal3 = ultimaVela_maioriaFuncao + 3;
              }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 5)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 4)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }
         else
            if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 3)
              {
               j = i;
               k = i;
               l = i + 1;
              }
            else
               if(metodoPosicoes_funcao == 1)
                 {
                  j = i;
                  k = i;
                  l = i;
                 }

      if(metodoPosicoes_funcao == 2 && ultimaVela_maioriaFuncao == 5)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = matrizMaioria_funcao[i][0];

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[i][1] == "0")
           {
            matrizEstrategia_funcao[i][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[i][1] != "0" && (StringToInteger(matrizMaioria_funcao[i][1]) != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "INV";

              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(matrizMaioria_funcao[i][1] == "0")
                 {
                  matrizEstrategia_funcao[i][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] != IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] == "0" && j + 2 < numeroLinhas_funcao &&
                         matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] != IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(matrizMaioria_funcao[i][1] == "0")
                       {
                        matrizEstrategia_funcao[i][1] = "SEM";
                       }
                     else
                        if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] != IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] != IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] == "0" && j + 3 < numeroLinhas_funcao &&
                            matrizMaioria_funcao[i + 3][1] != "0" && matrizMaioria_funcao[i + 3][1] != IntegerToString(quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "INV";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Maioria (M15 PDR)
void  PreencherQuadrante_EstrategiaMaioria_PDRM15(int  numeroLinhas_funcao, int &quadranteVelas_funcao[][4], string &matrizMaioria_funcao[][2], int ultimaVela_maioriaFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao == 3)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao != 3)
        {
         deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
        }

   if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 3)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }

   if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 0;
      deslocamentoFinal3 = 1;
     }
   else
      if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 3)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
         deslocamentoFinal3 = 2;
        }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 3)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 2)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }

      if(metodoPosicoes_funcao == 2 && ultimaVela_maioriaFuncao == 3)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = matrizMaioria_funcao[i][0];

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[i][1] == "0")
           {
            matrizEstrategia_funcao[i][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[i][1] != "0" && (StringToInteger(matrizMaioria_funcao[i][1]) == quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "PDR";

              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(matrizMaioria_funcao[i][1] == "0")
                 {
                  matrizEstrategia_funcao[i][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] == IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] == "0" && j + 2 < numeroLinhas_funcao &&
                         matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] == IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(matrizMaioria_funcao[i][1] == "0")
                       {
                        matrizEstrategia_funcao[i][1] = "SEM";
                       }
                     else
                        if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] == IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] == IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] == IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] == "0" && j + 3 < numeroLinhas_funcao &&
                            matrizMaioria_funcao[i + 3][1] != "0" && matrizMaioria_funcao[i + 3][1] == IntegerToString(quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "PDR";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Estratégias de Maioria (M15 INV)
void  PreencherQuadrante_EstrategiaMaioria_INVM15(int  numeroLinhas_funcao, int &quadranteVelas_funcao[][4], string &matrizMaioria_funcao[][2], int ultimaVela_maioriaFuncao, string &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   int   deslocamentoFinal = 0;
   int   deslocamentoFinal2 = 0;
   int   deslocamentoFinal3 = 0;
   int   j = 0;
   int   k = 0;
   int   l = 0;

   if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao == 3)
     {
      deslocamentoFinal = 0;
      numeroLinhas_funcao--;
     }
   else
      if(posicoesFuncao == 1 && ultimaVela_maioriaFuncao != 3)
        {
         deslocamentoFinal = ultimaVela_maioriaFuncao + 1;
        }

   if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 0;
     }
   else
      if(posicoesFuncao == 2 && ultimaVela_maioriaFuncao == 3)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
        }

   if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 2)
     {
      deslocamentoFinal = 3;
      deslocamentoFinal2 = 0;
      deslocamentoFinal3 = 1;
     }
   else
      if(posicoesFuncao == 3 && ultimaVela_maioriaFuncao == 3)
        {
         deslocamentoFinal = 0;
         deslocamentoFinal2 = 1;
         deslocamentoFinal3 = 2;
        }

   for(int i = 0; i < numeroLinhas_funcao; i++)
     {
      if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 3)
        {
         j = i + 1;
         k = i + 1;
         l = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 1 && ultimaVela_maioriaFuncao == 2)
           {
            j = i;
            k = i + 1;
            l = i + 1;
           }

      if(metodoPosicoes_funcao == 2 && ultimaVela_maioriaFuncao == 3)
        {
         j = i + 1;
        }
      else
         if(metodoPosicoes_funcao == 2)
           {
            j = i;
           }

      matrizEstrategia_funcao[i][0] = matrizMaioria_funcao[i][0];

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[i][1] == "0")
           {
            matrizEstrategia_funcao[i][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[i][1] != "0" && (StringToInteger(matrizMaioria_funcao[i][1]) != quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0)
              {
               matrizEstrategia_funcao[i][1] = "INV";

              }
            else
              {
               matrizEstrategia_funcao[i][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            //---próxima vela
            if(metodoPosicoes_funcao == 1 && k < numeroLinhas_funcao)
              {
               if(matrizMaioria_funcao[i][1] == "0")
                 {
                  matrizEstrategia_funcao[i][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                     (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0))
                    {
                     matrizEstrategia_funcao[i][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[i][1] = "OSS";
                    }
              }
            else
               //--- próximo quadrante
               if(metodoPosicoes_funcao == 2 && j + 1 < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] != IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i + 1][1] == "0" && j + 2 < numeroLinhas_funcao &&
                         matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] != IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
           }
         else
            if(posicoesFuncao == 3)
              {
               //---próxima vela
               if(metodoPosicoes_funcao == 1 && l < numeroLinhas_funcao)
                 {
                  if(matrizMaioria_funcao[i][1] == "0")
                    {
                     matrizEstrategia_funcao[i][1] = "SEM";
                    }
                  else
                     if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[k][deslocamentoFinal2]) && quadranteVelas_funcao[k][deslocamentoFinal2] != 0) ||
                        (matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[l][deslocamentoFinal3]) && quadranteVelas_funcao[l][deslocamentoFinal3] != 0))
                       {
                        matrizEstrategia_funcao[i][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[i][1] = "OSS";
                       }
                 }
               else
                  //--- próximo quadrante
                  if(metodoPosicoes_funcao == 2 && j + 2 < numeroLinhas_funcao)
                    {
                     if(matrizMaioria_funcao[i][1] == "0")
                       {
                        matrizEstrategia_funcao[i][1] = "SEM";
                       }
                     else
                        if((matrizMaioria_funcao[i][1] != "0" && matrizMaioria_funcao[i][1] != IntegerToString(quadranteVelas_funcao[j][deslocamentoFinal]) && quadranteVelas_funcao[j][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 1][1] != "0" && matrizMaioria_funcao[i + 1][1] != IntegerToString(quadranteVelas_funcao[j + 1][deslocamentoFinal]) && quadranteVelas_funcao[j + 1][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] != "0" && matrizMaioria_funcao[i + 2][1] != IntegerToString(quadranteVelas_funcao[j + 2][deslocamentoFinal]) && quadranteVelas_funcao[j + 2][deslocamentoFinal] != 0) ||
                           (matrizMaioria_funcao[i + 2][1] == "0" && j + 3 < numeroLinhas_funcao &&
                            matrizMaioria_funcao[i + 3][1] != "0" && matrizMaioria_funcao[i + 3][1] != IntegerToString(quadranteVelas_funcao[j + 3][deslocamentoFinal]) && quadranteVelas_funcao[j + 3][deslocamentoFinal] != 0))
                          {
                           matrizEstrategia_funcao[i][1] = "INV";
                          }
                        else
                          {
                           matrizEstrategia_funcao[i][1] = "OSS";
                          }
                    }
              }
     }
  }

//--- Complementação de Estratégias de Fluxo (M1 PDR - PROCEDIMENTO)
//--- Criar variáveis condicionais com velaComparacao_quadranteOriginal 1 e 2 e depois condição de posição 2 e 3
void   ComplementarEstrategia_FluxoPDR_M1(bool quadranteAcrescimo_checadoFuncao, int velaAtual_funcao,  int numeroLinhas_funcao, int  &quadranteVelas_funcao[][5], datetime  &periodoVelas_funcao[][5], int   &quadranteAcrescimo_funcao[], int  deslocamentoFuncao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if((quadranteAcrescimo_checadoFuncao == true && velaComparacao_funcao != 0) || (quadranteAcrescimo_checadoFuncao == true && velaAtual_funcao != 4))
     {
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
         if(posicoesFuncao == 1)
           {
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                    }
                  else
                     if(velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                       }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0 && velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao)))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                       }
                     else
                        if(velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao))
                          {
                           matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                          }
                 }
        }
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 2)
        {
         if(posicoesFuncao == 1)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao]);
               if(quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                    }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao]);
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                       }
                 }
        }
     }
  }

//--- Complementação de Estratégias de Fluxo (M1 INV - PROCEDIMENTO)
void   ComplementarEstrategia_FluxoINV_M1(bool quadranteAcrescimo_checadoFuncao, int velaAtual_funcao,  int numeroLinhas_funcao, int  &quadranteVelas_funcao[][5], datetime  &periodoVelas_funcao[][5], int   &quadranteAcrescimo_funcao[], int  deslocamentoFuncao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if((quadranteAcrescimo_checadoFuncao == true && velaComparacao_funcao != 0) || (quadranteAcrescimo_checadoFuncao == true && velaAtual_funcao != 4))
     {
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
         if(posicoesFuncao == 1)
           {
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                    }
                  else
                     if(velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                       }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0 && velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao)))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                       }
                     else
                        if(velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao))
                          {
                           matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                          }
                 }
        }
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 2)
        {
         if(posicoesFuncao == 1)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao]);
               if(quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                    }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao]);
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                       }
                 }
        }
     }
  }

//--- Complementação de Estratégias de Fluxo (M5 PDR - PROCEDIMENTO)
void   ComplementarEstrategia_FluxoPDR_M5(bool quadranteAcrescimo_checadoFuncao, int velaAtual_funcao,  int numeroLinhas_funcao, int  &quadranteVelas_funcao[][6], datetime  &periodoVelas_funcao[][6], int   &quadranteAcrescimo_funcao[], int  deslocamentoFuncao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if((quadranteAcrescimo_checadoFuncao == true && velaComparacao_funcao != 0) || (quadranteAcrescimo_checadoFuncao == true && velaAtual_funcao != 4))
     {
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao]);
         if(posicoesFuncao == 1)
           {
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                    }
                  else
                     if(velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                       }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0 && velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao)))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                       }
                     else
                        if(velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao))
                          {
                           matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                          }
                 }
        }
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 2)
        {
         if(posicoesFuncao == 1)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao]);
               if(quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                    }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao]);
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                       }
                 }
        }
     }
  }

//--- Complementação de Estratégias de Fluxo (M5 INV - PROCEDIMENTO)
void   ComplementarEstrategia_FluxoINV_M5(bool quadranteAcrescimo_checadoFuncao, int velaAtual_funcao,  int numeroLinhas_funcao, int  &quadranteVelas_funcao[][6], datetime  &periodoVelas_funcao[][6], int   &quadranteAcrescimo_funcao[], int  deslocamentoFuncao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if((quadranteAcrescimo_checadoFuncao == true && velaComparacao_funcao != 0) || (quadranteAcrescimo_checadoFuncao == true && velaAtual_funcao != 4))
     {
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
         if(posicoesFuncao == 1)
           {
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                    }
                  else
                     if(velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                       }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0 && velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao)))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                       }
                     else
                        if(velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao))
                          {
                           matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                          }
                 }
        }
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 2)
        {
         if(posicoesFuncao == 1)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao]);
               if(quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                    }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao]);
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                       }
                 }
        }
     }
  }

//--- Complementação de Estratégias de Fluxo (M15 PDR - PROCEDIMENTO)
void   ComplementarEstrategia_FluxoPDR_M15(bool quadranteAcrescimo_checadoFuncao, int velaAtual_funcao,  int numeroLinhas_funcao, int  &quadranteVelas_funcao[][4], datetime  &periodoVelas_funcao[][4], int   &quadranteAcrescimo_funcao[], int  deslocamentoFuncao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if((quadranteAcrescimo_checadoFuncao == true && velaComparacao_funcao != 0) || (quadranteAcrescimo_checadoFuncao == true && velaAtual_funcao != 4))
     {
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
         if(posicoesFuncao == 1)
           {
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                    }
                  else
                     if(velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                       }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0 && velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao)))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                       }
                     else
                        if(velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao))
                          {
                           matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                          }
                 }
        }
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 2)
        {
         if(posicoesFuncao == 1)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao]);
               if(quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                    }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao]);
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "PDR";
                       }
                     else
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                       }
                 }
        }
     }
  }

//--- Complementação de Estratégias de Fluxo (M15 INV - PROCEDIMENTO)
void   ComplementarEstrategia_FluxoINV_M15(bool quadranteAcrescimo_checadoFuncao, int velaAtual_funcao,  int numeroLinhas_funcao, int  &quadranteVelas_funcao[][4], datetime  &periodoVelas_funcao[][4], int   &quadranteAcrescimo_funcao[], int  deslocamentoFuncao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if((quadranteAcrescimo_checadoFuncao == true && velaComparacao_funcao != 0) || (quadranteAcrescimo_checadoFuncao == true && velaAtual_funcao != 4))
     {
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
         if(posicoesFuncao == 1)
           {
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                    }
                  else
                     if(velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                       }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0 && velaComparacao_funcao + 1 < ArraySize(quadranteAcrescimo_funcao)) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao + 1] && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0 && velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao)))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                       }
                     else
                        if(velaComparacao_funcao + 2 < ArraySize(quadranteAcrescimo_funcao))
                          {
                           matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                          }
                 }
        }
      if(quadranteAcrescimo_checadoFuncao == true && metodoPosicoes_funcao == 2)
        {
         if(posicoesFuncao == 1)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoFuncao]);
            if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] == 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "DOJ";
              }
            else
               if(quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 2)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao]);
               if(quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] == 0)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "DOJ";
                 }
               else
                  if((quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                    }
              }
            else
               if(posicoesFuncao == 3)
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao]);
                  if(quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] == 0)
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "DOJ";
                    }
                  else
                     if((quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 3][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 2][deslocamentoFuncao] != quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                        (quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != 0 && quadranteVelas_funcao[numeroLinhas_funcao - 1][deslocamentoFuncao] != quadranteAcrescimo_funcao[velaComparacao_funcao] && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "INV";
                       }
                     else
                       {
                        matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                       }
                 }
        }
     }
  }

//--- Complementação de Estratégias de Maiorias (M1 PDR - PROCEDIMENTO)
void   ComplementarEstrategia_MaioriaPDR_M1(int velaAtual_funcao, bool quadranteComplementar_verificarFuncao, int numeroLinhas_funcao, string &matrizMaioria_funcao[][2], int &quadranteVelas_funcao[][5], datetime  &periodoVelas_funcao[][5], int   &quadranteAcrescimo_funcao[], int deslocamentoPeriodo_funcao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if(velaAtual_funcao == 4 && quadranteComplementar_verificarFuncao == false)
     {
      numeroLinhas_funcao--;
     }

//--- Próxima Vela
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 4) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 1)
     {
      matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 1][deslocamentoPeriodo_funcao]);

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2 && (velaAtual_funcao >= 2 && velaAtual_funcao <= 4))
           {
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 1]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 3 && (velaAtual_funcao >= 3 && velaAtual_funcao <= 4))
              {
               if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao] + 1) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 2]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                    }
              }

     }

//--- Próximo Quadrante
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 4) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 2)
     {
      if(posicoesFuncao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 1][deslocamentoPeriodo_funcao]);
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoPeriodo_funcao]);
            if(matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                 }

           }
         else
            if(posicoesFuncao == 3)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoPeriodo_funcao]);
               if(matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                    }

              }
     }
  }

//--- Complementação de Estratégias de Maiorias (M1 INV - PROCEDIMENTO)
void   ComplementarEstrategia_MaioriaINV_M1(int velaAtual_funcao, bool quadranteComplementar_verificarFuncao, int numeroLinhas_funcao, string &matrizMaioria_funcao[][2], int &quadranteVelas_funcao[][5], datetime  &periodoVelas_funcao[][5], int   &quadranteAcrescimo_funcao[], int deslocamentoPeriodo_funcao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if(velaAtual_funcao == 4 && quadranteComplementar_verificarFuncao == false)
     {
      numeroLinhas_funcao--;
     }

//--- Próxima Vela
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 4) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 1)
     {
      matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2 && (velaAtual_funcao >= 2 && velaAtual_funcao <= 4))
           {
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 1]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 3 && (velaAtual_funcao >= 3 && velaAtual_funcao <= 4))
              {
               if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao] + 1) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 2]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                    }
              }

     }

//--- Próximo Quadrante
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 4) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 2)
     {
      if(posicoesFuncao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoPeriodo_funcao]);
            if(matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                 }

           }
         else
            if(posicoesFuncao == 3)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoPeriodo_funcao]);
               if(matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                    }

              }
     }
  }

//--- Complementação de Estratégias de Maiorias (M5 PDR - PROCEDIMENTO)
void   ComplementarEstrategia_MaioriaPDR_M5(int velaAtual_funcao, bool quadranteComplementar_verificarFuncao, int numeroLinhas_funcao, string &matrizMaioria_funcao[][2], int &quadranteVelas_funcao[][6], datetime  &periodoVelas_funcao[][6], int   &quadranteAcrescimo_funcao[], int deslocamentoPeriodo_funcao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if(velaAtual_funcao == 4 && quadranteComplementar_verificarFuncao == false)
     {
      numeroLinhas_funcao--;
     }

//--- Próxima Vela
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 5) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 1)
     {
      matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2 && (velaAtual_funcao >= 2 && velaAtual_funcao <= 5))
           {
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 1]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 3 && (velaAtual_funcao >= 3 && velaAtual_funcao <= 5))
              {
               if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao] + 1) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 2]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                    }
              }

     }

//--- Próximo Quadrante
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 5) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 2)
     {
      if(posicoesFuncao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoPeriodo_funcao]);
            if(matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                 }

           }
         else
            if(posicoesFuncao == 3)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoPeriodo_funcao]);
               if(matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                    }

              }
     }
  }

//--- Complementação de Estratégias de Maiorias (M5 INV - PROCEDIMENTO)
void   ComplementarEstrategia_MaioriaINV_M5(int velaAtual_funcao, bool quadranteComplementar_verificarFuncao, int numeroLinhas_funcao, string &matrizMaioria_funcao[][2], int &quadranteVelas_funcao[][6], datetime  &periodoVelas_funcao[][6], int   &quadranteAcrescimo_funcao[], int deslocamentoPeriodo_funcao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if(velaAtual_funcao == 4 && quadranteComplementar_verificarFuncao == false)
     {
      numeroLinhas_funcao--;
     }

//--- Próxima Vela
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 5) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 1)
     {
      matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2 && (velaAtual_funcao >= 2 && velaAtual_funcao <= 5))
           {
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 1]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 3 && (velaAtual_funcao >= 3 && velaAtual_funcao <= 5))
              {
               if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao] + 1) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 2]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                    }
              }

     }

//--- Próximo Quadrante
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 5) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 2)
     {
      if(posicoesFuncao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoPeriodo_funcao]);
            if(matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                 }

           }
         else
            if(posicoesFuncao == 3)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoPeriodo_funcao]);
               if(matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                    }

              }
     }
  }

//--- Complementação de Estratégias de Maiorias (M15 PDR - PROCEDIMENTO)
void   ComplementarEstrategia_MaioriaPDR_M15(int velaAtual_funcao, bool quadranteComplementar_verificarFuncao, int numeroLinhas_funcao, string &matrizMaioria_funcao[][2], int &quadranteVelas_funcao[][4], datetime  &periodoVelas_funcao[][4], int   &quadranteAcrescimo_funcao[], int deslocamentoPeriodo_funcao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if(velaAtual_funcao == 4 && quadranteComplementar_verificarFuncao == false)
     {
      numeroLinhas_funcao--;
     }

//--- Próxima Vela
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 3) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 1)
     {
      matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2 && (velaAtual_funcao >= 2 && velaAtual_funcao <= 3))
           {
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 1]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 3 && (velaAtual_funcao == 3))
              {
               if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao] + 1) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 2]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                    }
              }

     }

//--- Próximo Quadrante
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 3) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 2)
     {
      if(posicoesFuncao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "PDR";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoPeriodo_funcao]);
            if(matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "PDR";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                 }

           }
         else
            if(posicoesFuncao == 3)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 3][deslocamentoPeriodo_funcao]);
               if(matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "PDR";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                    }

              }
     }
  }

//--- Complementação de Estratégias de Maiorias (M15 INV - PROCEDIMENTO)
void   ComplementarEstrategia_MaioriaINV_M15(int velaAtual_funcao, bool quadranteComplementar_verificarFuncao, int numeroLinhas_funcao, string &matrizMaioria_funcao[][2], int &quadranteVelas_funcao[][4], datetime  &periodoVelas_funcao[][4], int   &quadranteAcrescimo_funcao[], int deslocamentoPeriodo_funcao, int  velaComparacao_funcao, string   &matrizEstrategia_funcao[][2], int  posicoesFuncao, int  metodoPosicoes_funcao)
  {
   if(velaAtual_funcao == 4 && quadranteComplementar_verificarFuncao == false)
     {
      numeroLinhas_funcao--;
     }

//--- Próxima Vela
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 3) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 1)
     {
      matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);

      if(posicoesFuncao == 1)
        {
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2 && (velaAtual_funcao >= 2 && velaAtual_funcao <= 3))
           {
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 1]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                 }
           }
         else
            if(posicoesFuncao == 3 && (velaAtual_funcao == 3))
              {
               if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao] + 1) && quadranteAcrescimo_funcao[velaComparacao_funcao + 1] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao + 2]) && quadranteAcrescimo_funcao[velaComparacao_funcao + 2] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
                    }
              }

     }

//--- Próximo Quadrante
   if(((velaAtual_funcao >= 1 && velaAtual_funcao <= 3) || quadranteComplementar_verificarFuncao == true) && metodoPosicoes_funcao == 2)
     {
      if(posicoesFuncao == 1)
        {
         matrizEstrategia_funcao[numeroLinhas_funcao - 1][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 1][deslocamentoPeriodo_funcao]);
         if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] == "0")
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "SEM";
           }
         else
            if(matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "INV";
              }
            else
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 1][1] = "OSS";
              }
        }
      else
         if(posicoesFuncao == 2)
           {
            matrizEstrategia_funcao[numeroLinhas_funcao - 2][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao - 2][deslocamentoPeriodo_funcao]);
            if(matrizMaioria_funcao[numeroLinhas_funcao - 2][1] == "0")
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "SEM";
              }
            else
               if((matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                  (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "INV";
                 }
               else
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 2][1] = "OSS";
                 }

           }
         else
            if(posicoesFuncao == 3)
              {
               matrizEstrategia_funcao[numeroLinhas_funcao - 3][0] = TimeToString(periodoVelas_funcao[numeroLinhas_funcao- 3][deslocamentoPeriodo_funcao]);
               if(matrizMaioria_funcao[numeroLinhas_funcao - 3][1] == "0")
                 {
                  matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "SEM";
                 }
               else
                  if((matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 3][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 2][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 2][1] != IntegerToString(quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao]) && quadranteVelas_funcao[numeroLinhas_funcao - 1][velaComparacao_funcao] != 0) ||
                     (matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != "0" && matrizMaioria_funcao[numeroLinhas_funcao - 1][1] != IntegerToString(quadranteAcrescimo_funcao[velaComparacao_funcao]) && quadranteAcrescimo_funcao[velaComparacao_funcao] != 0))
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "INV";
                    }
                  else
                    {
                     matrizEstrategia_funcao[numeroLinhas_funcao - 3][1] = "OSS";
                    }

              }
     }
  }

//--- Detectar Sinal Kataná PDR nas Estratégias
string  DetectarSinal_KatanaPDR(string  &matrizEstrategia_funcao[][2], int katanaBarreira_funcao, double porcentagemOcorrencias_funcao, bool  porcentagemBarreira_funcao, double mediaPorcentagem_ocorrenciasFuncao)
  {
   string     matrizEditada[][2];
   string     matrizIndices_finaisFuncao[][2];
   int        numeroLinhas_matrizOriginal_funcao = ArrayRange(matrizEstrategia_funcao, 0);
   int        numeroLinhas_matrizEditada_funcao = 0;
   int        numeroLinhas_indicesFinais_funcao = 1 + katanaBarreira_funcao;
   int        indiceInicial_funcao = 0;
   int        j = 0;
   int        k = 0;
   int        contadorExcesso = 0;
   int        contadorLoss = 0;
   string     sinalKatana_detectadoFuncao = "-";

   ArrayResize(matrizEditada, numeroLinhas_matrizOriginal_funcao);

   for(int i = 0; i < numeroLinhas_matrizOriginal_funcao; i++)
     {
      if(matrizEstrategia_funcao[i][1] == "PDR" || matrizEstrategia_funcao[i][1] == "OSS")
        {
         matrizEditada[j][0] = matrizEstrategia_funcao[i][0];
         matrizEditada[j][1] = matrizEstrategia_funcao[i][1];
         j += 1;
        }
      else
        {
         contadorExcesso += 1;
        }
     }

   ArrayResize(matrizEditada, numeroLinhas_matrizOriginal_funcao - contadorExcesso, 0);
   numeroLinhas_matrizEditada_funcao = ArrayRange(matrizEditada, 0);

   indiceInicial_funcao = numeroLinhas_matrizEditada_funcao - katanaBarreira_funcao -1;
   if(indiceInicial_funcao < 0)
     {
      indiceInicial_funcao = 0;
     }

   ArrayResize(matrizIndices_finaisFuncao, numeroLinhas_indicesFinais_funcao, 0);
   for(int i = indiceInicial_funcao; i < numeroLinhas_matrizEditada_funcao; i++)
     {
      matrizIndices_finaisFuncao[k][0] = matrizEditada[i][0];
      matrizIndices_finaisFuncao[k][1] = matrizEditada[i][1];
      k += 1;
     }

   for(int i = 1; i < numeroLinhas_indicesFinais_funcao; i++)
     {
      if(matrizIndices_finaisFuncao[i][1] == "OSS")
        {
         contadorLoss += 1;
        }

     }

   if(porcentagemBarreira_funcao == true)
     {
      if(matrizIndices_finaisFuncao[0][1] == "PDR" && contadorLoss == katanaBarreira_funcao &&
         porcentagemOcorrencias_funcao >= mediaPorcentagem_ocorrenciasFuncao)
        {
         sinalKatana_detectadoFuncao = "KATANÁ!";
        }
     }
   else
     {
      if(matrizIndices_finaisFuncao[0][1] == "PDR" && contadorLoss == katanaBarreira_funcao)
        {
         sinalKatana_detectadoFuncao = "KATANÁ!";
        }
     }

   return   sinalKatana_detectadoFuncao;
  }

//--- Detectar Sinal Kataná INV nas Estratégias
string  DetectarSinal_KatanaINV(string  &matrizEstrategia_funcao[][2], int katanaBarreira_funcao, double porcentagemOcorrencias_funcao, bool  porcentagemBarreira_funcao, double mediaPorcentagem_ocorrenciasFuncao)
  {
   string     matrizEditada[][2];
   string     matrizIndices_finaisFuncao[][2];
   int        numeroLinhas_matrizOriginal_funcao = ArrayRange(matrizEstrategia_funcao, 0);
   int        numeroLinhas_matrizEditada_funcao = 0;
   int        numeroLinhas_indicesFinais_funcao = 1 + katanaBarreira_funcao;
   int        indiceInicial_funcao = 0;
   int        j = 0;
   int        k = 0;
   int        contadorExcesso = 0;
   int        contadorLoss = 0;
   string     sinalKatana_detectadoFuncao = "-";

   ArrayResize(matrizEditada, numeroLinhas_matrizOriginal_funcao);

   for(int i = 0; i < numeroLinhas_matrizOriginal_funcao; i++)
     {
      if(matrizEstrategia_funcao[i][1] == "INV" || matrizEstrategia_funcao[i][1] == "OSS")
        {
         matrizEditada[j][0] = matrizEstrategia_funcao[i][0];
         matrizEditada[j][1] = matrizEstrategia_funcao[i][1];
         j += 1;
        }
      else
        {
         contadorExcesso += 1;
        }
     }

   ArrayResize(matrizEditada, numeroLinhas_matrizOriginal_funcao - contadorExcesso, 0);
   numeroLinhas_matrizEditada_funcao = ArrayRange(matrizEditada, 0);

   indiceInicial_funcao = numeroLinhas_matrizEditada_funcao - katanaBarreira_funcao -1;
   if(indiceInicial_funcao < 0)
     {
      indiceInicial_funcao = 0;
     }

   ArrayResize(matrizIndices_finaisFuncao, numeroLinhas_indicesFinais_funcao, 0);
   for(int i = indiceInicial_funcao; i < numeroLinhas_matrizEditada_funcao; i++)
     {
      matrizIndices_finaisFuncao[k][0] = matrizEditada[i][0];
      matrizIndices_finaisFuncao[k][1] = matrizEditada[i][1];
      k += 1;
     }

   for(int i = 1; i < numeroLinhas_indicesFinais_funcao; i++)
     {
      if(matrizIndices_finaisFuncao[i][1] == "OSS")
        {
         contadorLoss += 1;
        }
     }

   if(porcentagemBarreira_funcao == true)
     {
      if(matrizIndices_finaisFuncao[0][1] == "INV" && contadorLoss == katanaBarreira_funcao &&
         porcentagemOcorrencias_funcao >= mediaPorcentagem_ocorrenciasFuncao)
        {
         sinalKatana_detectadoFuncao = "KATANÁ!";
        }
     }
   else
     {
      if(matrizIndices_finaisFuncao[0][1] == "PDR" && contadorLoss == katanaBarreira_funcao)
        {
         sinalKatana_detectadoFuncao = "KATANÁ!";
        }
     }

   return   sinalKatana_detectadoFuncao;
  }
//+------------------------------------------------------------------+

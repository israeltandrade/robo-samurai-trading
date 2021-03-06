//+------------------------------------------------------------------+
//|                                           ES_funcoesGraficas.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"

//--- CRIAR BOTÃO (PROCEDIMENTO)
void  CriarBotao(string            nome,
                 ENUM_BASE_CORNER  canto,
                 int               distanciaX,
                 int               distanciaY,
                 int               largura,
                 int               altura,
                 string            texto,
                 string            fonte,
                 int               tamanhoFonte,
                 color             corTexto,
                 color             corFundo,
                 color             corBorda,
                 bool              fundo,
                 bool              oculto,
                 bool              selecionavel,
                 string            dica = NULL)
  {
   ObjectCreate(0, nome, OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, nome, OBJPROP_CORNER, canto);
   ObjectSetInteger(0, nome, OBJPROP_XDISTANCE, distanciaX);
   ObjectSetInteger(0, nome, OBJPROP_YDISTANCE, distanciaY);
   ObjectSetInteger(0, nome, OBJPROP_XSIZE, largura);
   ObjectSetInteger(0, nome, OBJPROP_YSIZE, altura);
   ObjectSetString(0, nome, OBJPROP_TEXT, texto);
   ObjectSetString(0, nome, OBJPROP_FONT, fonte);
   ObjectSetInteger(0, nome, OBJPROP_FONTSIZE, tamanhoFonte);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, corTexto);
   ObjectSetInteger(0, nome, OBJPROP_BGCOLOR, corFundo);
   ObjectSetInteger(0, nome, OBJPROP_BORDER_COLOR, corBorda);
   ObjectSetInteger(0, nome, OBJPROP_BACK, fundo);
   ObjectSetInteger(0, nome, OBJPROP_HIDDEN, oculto);
   ObjectSetInteger(0, nome, OBJPROP_SELECTABLE, selecionavel);
   ObjectSetString(0, nome, OBJPROP_TOOLTIP, dica);
   ChartRedraw();
  }

//--- PRESSIONAR BOTÃO (PROCEDIMENTO)
void  PressionarBotao(string   botaoPressionado,
                      string   botaoA,
                      string   botaoB,
                      string   botaoC,
                      string   botaoD,
                      string   botaoE,
                      string   botaoF,
                      string   botaoG,
                      string   botaoH,
                      string   botaoI,
                      string   botaoJ
                     )
  {
   ObjectSetInteger(0, botaoPressionado, OBJPROP_STATE, true);
   ObjectSetInteger(0, botaoA, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoB, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoC, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoD, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoE, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoF, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoG, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoH, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoI, OBJPROP_STATE, false);
   ObjectSetInteger(0, botaoJ, OBJPROP_STATE, false);
  }

//--- BOTÃO OCULTAR (PROCEDIMENTO)
void  BotaoOcultar(int  botaoSelecionado_funcao,
                   bool mostrarPainel_funcao)
  {
   if(mostrarPainel_funcao == false)
     {
      ObjectSetInteger(0, "Botão 1", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 2", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 3", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 4", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 5", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 6", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 7", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 8", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 9", OBJPROP_STATE, true);
      ObjectSetInteger(0, "Botão 10", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 11", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 12", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 13", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 14", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Botão 15", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Fundo 1", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Fundo 2", OBJPROP_XDISTANCE, 20000);
      ObjectSetInteger(0, "Fundo 3", OBJPROP_XDISTANCE, 20000);

     }
   else
      if(mostrarPainel_funcao == true)
        {
         ObjectSetInteger(0, "Botão 1", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 2", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 3", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 4", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 5", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 6", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 7", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 8", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 9", OBJPROP_STATE, false);
         ObjectSetInteger(0, "Botão 10", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 11", OBJPROP_XDISTANCE, 500);
         ObjectSetInteger(0, "Botão 12", OBJPROP_XDISTANCE, 20000);
         ObjectSetInteger(0, "Botão 13", OBJPROP_XDISTANCE, 20000);
         ObjectSetInteger(0, "Botão 14", OBJPROP_XDISTANCE, 20000);
         ObjectSetInteger(0, "Botão 15", OBJPROP_XDISTANCE, 20000);
         ObjectSetInteger(0, "Fundo 1", OBJPROP_XDISTANCE, 10);
         ObjectSetInteger(0, "Fundo 2", OBJPROP_XDISTANCE, 635);

         switch(botaoSelecionado_funcao)
           {
            case 1:
               ObjectSetInteger(0, "Botão 1", OBJPROP_STATE, true);
               break;
            case 2:
               ObjectSetInteger(0, "Botão 2", OBJPROP_STATE, true);
               break;
            case 3:
               ObjectSetInteger(0, "Botão 3", OBJPROP_STATE, true);
               break;
            case 4:
               ObjectSetInteger(0, "Botão 4", OBJPROP_STATE, true);
               break;
            case 5:
               ObjectSetInteger(0, "Botão 5", OBJPROP_STATE, true);
               break;
            case 6:
               ObjectSetInteger(0, "Botão 6", OBJPROP_STATE, true);
               break;
            case 7:
               ObjectSetInteger(0, "Botão 7", OBJPROP_STATE, true);
               break;
            case 8:
               ObjectSetInteger(0, "Botão 8", OBJPROP_STATE, true);
               break;
            case 9:
               ObjectSetInteger(0, "Botão 9", OBJPROP_STATE, true);
               break;
            case 10:
               ObjectSetInteger(0, "Botão 10", OBJPROP_STATE, true);
               break;
            case 11:
               ObjectSetInteger(0, "Botão 11", OBJPROP_STATE, true);
               break;
            case 12:
               ObjectSetInteger(0, "Botão 12", OBJPROP_STATE, true);
               break;
            case 13:
               ObjectSetInteger(0, "Botão 13", OBJPROP_STATE, true);
               break;
            case 14:
               ObjectSetInteger(0, "Botão 14", OBJPROP_STATE, true);
               break;
            case 15:
               ObjectSetInteger(0, "Botão 15", OBJPROP_STATE, true);
               break;
           }
        }
  }

//--- CRIAR FUNDO DE PAINEL (PROCEDIMENTO)
void  CriarFundo(string             nome,
                 ENUM_BASE_CORNER   canto,
                 int                distanciaX,
                 int                distanciaY,
                 int                largura,
                 int                altura,
                 color              corFundo,
                 ENUM_BORDER_TYPE   borda,
                 color              corBorda,
                 bool               oculto,
                 int                camada)
  {
   ObjectCreate(0, nome, OBJ_RECTANGLE_LABEL, 0, 0, 0);
   ObjectSetInteger(0, nome, OBJPROP_CORNER, canto);
   ObjectSetInteger(0, nome, OBJPROP_XDISTANCE, distanciaX);
   ObjectSetInteger(0, nome, OBJPROP_YDISTANCE, distanciaY);
   ObjectSetInteger(0, nome, OBJPROP_XSIZE, largura);
   ObjectSetInteger(0, nome, OBJPROP_YSIZE, altura);
   ObjectSetInteger(0, nome, OBJPROP_BGCOLOR, corFundo);
   ObjectSetInteger(0, nome, OBJPROP_BORDER_TYPE, borda);
   ObjectSetInteger(0, nome, OBJPROP_BORDER_COLOR, corBorda);
   ObjectSetInteger(0, nome, OBJPROP_HIDDEN, oculto);
   ObjectSetInteger(0, nome, OBJPROP_ZORDER, camada);
   ChartRedraw();
  }

//--- AJUSTAR ALTURA DO PAINEL (PROCEDIMENTO)
void  AjustarAltura_Painel(string   nome,
                           int      distanciaY,
                           int      altura,
                           bool     oculto,
                           int      camada)
  {
   ObjectSetInteger(0, nome, OBJPROP_YDISTANCE, distanciaY);
   ObjectSetInteger(0, nome, OBJPROP_YSIZE, altura);
   ObjectSetInteger(0, nome, OBJPROP_HIDDEN, oculto);
   ObjectSetInteger(0, nome, OBJPROP_ZORDER, camada);
   ChartRedraw();
  }

//--- AJUSTAR POSIÇÃO X (PROCEDIMENTO)
void  AjustarPosicao_X(string nome,
                       int    distanciaX)
  {
   ObjectSetInteger(0, nome, OBJPROP_XDISTANCE, distanciaX);
   ChartRedraw();
  }

//--- AJUSTAR POSIÇÃO Y (PROCEDIMENTO)
void  AjustarPosicao_Y(string nome,
                       int    distanciaY)
  {
   ObjectSetInteger(0, nome, OBJPROP_YDISTANCE, distanciaY);
   ChartRedraw();
  }

//--- CRIAR TEXTO DO PAINEL (PROCEDIMENTO)
void  CriarTexto_Painel(string             nome,
                        ENUM_BASE_CORNER   canto,
                        ENUM_ANCHOR_POINT  ancora,
                        int                distanciaX,
                        int                distanciaY,
                        string             texto,
                        string             fonte,
                        int                tamanhoFonte,
                        color              corTexto,
                        int                camada)
  {
   ObjectCreate(0, nome, OBJ_LABEL, 0, 0, 0);
   ObjectSetInteger(0, nome, OBJPROP_CORNER, canto);
   ObjectSetInteger(0, nome, OBJPROP_ANCHOR, ancora);
   ObjectSetInteger(0, nome, OBJPROP_XDISTANCE, distanciaX);
   ObjectSetInteger(0, nome, OBJPROP_YDISTANCE, distanciaY);
   ObjectSetString(0, nome, OBJPROP_TEXT, texto);
   ObjectSetString(0, nome, OBJPROP_FONT, fonte);
   ObjectSetInteger(0, nome, OBJPROP_FONTSIZE, tamanhoFonte);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, corTexto);
   ObjectSetInteger(0, nome, OBJPROP_ZORDER, camada);
   ChartRedraw();
  }

//--- POSICIONAR IMAGEM NO PAINEL (PROCEDIMENTO)
void  PosicionarImagem_Painel(string             nome,
                              string             imagem,
                              ENUM_BASE_CORNER   canto,
                              ENUM_ANCHOR_POINT  ancora,
                              int                distanciaX,
                              int                distanciaY,
                              int                camada)
  {
   ObjectCreate(0, nome, OBJ_BITMAP_LABEL, 0, 0, 0);
   ObjectSetString(0, nome, OBJPROP_BMPFILE, imagem);
   ObjectSetInteger(0, nome, OBJPROP_CORNER, canto);
   ObjectSetInteger(0, nome, OBJPROP_ANCHOR, ancora);
   ObjectSetInteger(0, nome, OBJPROP_XDISTANCE, distanciaX);
   ObjectSetInteger(0, nome, OBJPROP_YDISTANCE, distanciaY);
   ObjectSetInteger(0, nome, OBJPROP_ZORDER, camada);
   ChartRedraw();
  }

//--- APAGAR TEXTOS DO PAINEL (PROCEDIMENTO)
void  ApagarTexto_Painel(string  &texto1[],
                         string  &texto2[],
                         string  &texto3[],
                         string  &texto4[],
                         string  &texto5[],
                         string  &texto6[],
                         string  &texto7[],
                         string  &texto8[],
                         string  &texto9[],
                         string  &texto10[],
                         string  &texto11[],
                         string  &texto12[],
                         string  &texto13[],
                         string  &texto14[],
                         string  &texto15[],
                         string  &texto16[][5],
                         string  &texto17[][6],
                         string  &texto18[][4],
                         string  &texto19[],
                         string  &texto20[],
                         string  &texto21[],
                         string  &texto22[],
                         string  &texto23[],
                         string  &texto24[],
                         string  &texto25[],
                         string  &texto26[],
                         string  &texto27[],
                         string  &texto28[],
                         string  &texto29[],
                         string  &texto30[],
                         string  &texto31[][4],
                         string  &texto32[][4],
                         string  &texto33[][3],
                         string  &texto34[],
                         string  &texto35[],
                         string  &texto36[],
                         string  &texto37[],
                         string  &texto38[][2])

  {
   for(int i = 0; i < ArraySize(texto1) ; i++)
     {
      ObjectDelete(0, texto1[i]);
     }
   for(int i = 0; i < ArraySize(texto2) ; i++)
     {
      ObjectDelete(0, texto2[i]);
     }
   for(int i = 0; i < ArraySize(texto3) ; i++)
     {
      ObjectDelete(0, texto3[i]);
     }
   for(int i = 0; i < ArraySize(texto4) ; i++)
     {
      ObjectDelete(0, texto4[i]);
     }
   for(int i = 0; i < ArraySize(texto5) ; i++)
     {
      ObjectDelete(0, texto5[i]);
     }
   for(int i = 0; i < ArraySize(texto6) ; i++)
     {
      ObjectDelete(0, texto6[i]);
     }
   for(int i = 0; i < ArraySize(texto7) ; i++)
     {
      ObjectDelete(0, texto7[i]);
     }
   for(int i = 0; i < ArraySize(texto8) ; i++)
     {
      ObjectDelete(0, texto8[i]);
     }
   for(int i = 0; i < ArraySize(texto9) ; i++)
     {
      ObjectDelete(0, texto9[i]);
     }
   for(int i = 0; i < ArraySize(texto10) ; i++)
     {
      ObjectDelete(0, texto10[i]);
     }
   for(int i = 0; i < ArrayRange(texto11, 0) ; i++)
     {
      ObjectDelete(0, texto11[i]);
     }
   for(int i = 0; i < ArrayRange(texto12, 0) ; i++)
     {
      ObjectDelete(0, texto12[i]);
     }
   for(int i = 0; i < ArrayRange(texto13, 0) ; i++)
     {
      ObjectDelete(0, texto13[i]);
     }

   for(int i = 0; i < ArraySize(texto14) ; i++)
     {
      ObjectDelete(0, texto14[i]);
     }
   for(int i = 0; i < ArraySize(texto15) ; i++)
     {
      ObjectDelete(0, texto15[i]);
     }
   for(int i = 0; i < ArrayRange(texto16, 0) ; i++)
     {
      for(int j = 0; j < 5; j++)
        {
         ObjectDelete(0, texto16[i][j]);
        }
     }
   for(int i = 0; i < ArrayRange(texto17, 0) ; i++)
     {
      for(int j = 0; j < 6; j++)
        {
         ObjectDelete(0, texto17[i][j]);
        }
     }
   for(int i = 0; i < ArrayRange(texto18, 0) ; i++)
     {
      for(int j = 0; j < 4; j++)
        {
         ObjectDelete(0, texto18[i][j]);
        }
     }
   for(int i = 0; i < ArraySize(texto19) ; i++)
     {
      ObjectDelete(0, texto19[i]);
     }
   for(int i = 0; i < ArraySize(texto20) ; i++)
     {
      ObjectDelete(0, texto20[i]);
     }
   for(int i = 0; i < ArraySize(texto21) ; i++)
     {
      ObjectDelete(0, texto21[i]);
     }
   for(int i = 0; i < ArraySize(texto22) ; i++)
     {
      ObjectDelete(0, texto22[i]);
     }
   for(int i = 0; i < ArraySize(texto23) ; i++)
     {
      ObjectDelete(0, texto23[i]);
     }
   for(int i = 0; i < ArraySize(texto24) ; i++)
     {
      ObjectDelete(0, texto24[i]);
     }
   for(int i = 0; i < ArraySize(texto25) ; i++)
     {
      ObjectDelete(0, texto25[i]);
     }
   for(int i = 0; i < ArraySize(texto26) ; i++)
     {
      ObjectDelete(0, texto26[i]);
     }
   for(int i = 0; i < ArraySize(texto27) ; i++)
     {
      ObjectDelete(0, texto27[i]);
     }
   for(int i = 0; i < ArraySize(texto28) ; i++)
     {
      ObjectDelete(0, texto28[i]);
     }
   for(int i = 0; i < ArraySize(texto29) ; i++)
     {
      ObjectDelete(0, texto29[i]);
     }
   for(int i = 0; i < ArraySize(texto30) ; i++)
     {
      ObjectDelete(0, texto30[i]);
     }
   for(int i = 0; i < ArrayRange(texto31, 0) ; i++)
     {
      for(int j = 0; j < 4; j++)
        {
         ObjectDelete(0, texto31[i][j]);
        }
     }
   for(int i = 0; i < ArrayRange(texto32, 0) ; i++)
     {
      for(int j = 0; j < 4; j++)
        {
         ObjectDelete(0, texto32[i][j]);
        }
     }
   for(int i = 0; i < ArrayRange(texto33, 0) ; i++)
     {
      for(int j = 0; j < 3; j++)
        {
         ObjectDelete(0, texto33[i][j]);
        }
     }
   for(int i = 0; i < ArraySize(texto34) ; i++)
     {
      ObjectDelete(0, texto34[i]);
     }
   for(int i = 0; i < ArraySize(texto35) ; i++)
     {
      ObjectDelete(0, texto35[i]);
     }
   for(int i = 0; i < ArraySize(texto36) ; i++)
     {
      ObjectDelete(0, texto36[i]);
     }
   for(int i = 0; i < ArraySize(texto37) ; i++)
     {
      ObjectDelete(0, texto37[i]);
     }
   for(int i = 0; i < ArrayRange(texto38, 0) ; i++)
     {
      for(int j = 0; j < 2; j++)
        {
         ObjectDelete(0, texto38[i][j]);
        }
     }
  }
//+------------------------------------------------------------------+

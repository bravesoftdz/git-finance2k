unit LibMega;

interface

uses
  Classes, db,  Windows, Dialogs,
  EMsgDlg, SysUtils, Forms, ELibFnc,  DBCommon, DBGrids,
  stdctrls, checklst, ENumEd, RxLookup, Mask, buttons, Registry,
  EDrvBox, Messages, Controls, DBClient,  Constants,
  ExtCtrls, ComCtrls, Graphics, SqlExpr, Math, DBCtrls, EChkGrp,
  TypInfo, EDateEd, EMonthYear,  UVarGlobais,
//  {$IFDEF VER150}
//    ToolEdit, CurrEdit,
//  {$ENDIF}
//  {$ELSE}
//  {$IFDEF VER230}
   // RDprint, RxToolEdit, RxCurrEdit, System.RegularExpressions,
//  {$ENDIF}
  Util,
  {In�cio units do FireDac}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;
  {Fim units do FireDac}

type
  TIntArray = array of integer;
  TStrArray = array of string;
  TFeriados = (frPascoa, frCarnaval, frQuartaCinzas, frSextaSanta, frCorpusChristi);


type
  TLibMega = class(TComponent)

  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

const
  StartKey = 321; {Start default key}
  MultKey  = 1;	  {Mult default key}
  AddKey	 = 3;	  {Add default key}

procedure Register;

// Funcoes de Cria��o de tabelas


//function CriaTabTUsersIBx(sPath:String): boolean;
//function CriaTabCadastro(sPath:String): boolean;
//function CriaTabContabil(sPath:String): boolean;
//function CriaTabFinanceiro(sPath:string): Boolean;
{Cria e preenche as tabelas do programa pessoal que ser�o utilizadas
pelo PPP. }
//function CriaTabPessoalPPP(sPath:string): Boolean;

//Criptografia
function Encrypt(InString: String): String;
function Decrypt(InString: String): String;
function BinaryMethod(const aText: string; aKey: word): string;
function fCripto( sLinha:String ):string;
function fDeCripto( sLinha:String ):string;

{Feriados}
function CalculaPascoa(AAno: Word): TDateTime;
function CalculaFeriado(AAno: Word; ATipo: TFeriados): TDate;
function fGravaFeriados(pbAtualiza: Boolean = False): Boolean; {Grava ou atualiza a tabela com todos os feriados nacionais m�veis e fixos de 1980 a 2050}
function QtdeferiadosPeriodo(pdDataI,pdDataF: TDateTime; poConn: TFDConnection;
  pbSabadoUtil: boolean): Integer;

{Datas}
function AcrescMinutos(dData:TDateTime;iMinutos:integer):TDateTime;//Acrescenta N minutos a uma dataHora
function IncDecAnos(pdData: TDateTime; piAnos:integer): TDateTime;//Incrementa ou decrementa anos a uma data (Se iAnos for positivo incrementa, negativo decrementa)
function IncDecMes(dData:TDateTime;iTempo:Integer):TDateTime; //Se positivo, incrementa m�s(es). Se negativo decrementa m�s(es)
{ValidaData Retorna true se a data contida no componente TDateEdit passado
por par�metro for v�lida. Deve ser colocado nos eventos OnChange e OnExit do
do componente TDateEdit. Sendo que, no evento onChange, deve-se atribuir False
ao par�metro pbOnExit}
//function ValidaData(TData: TDateEdit; pbOnExit: Boolean = True): boolean;overload;
function ValidaData(TData: TEvMonthYear; pbOnExit: Boolean = True): boolean;overload;
{ValidaDataExit Retorna true se a data contida no componente TDateEdit passado
por par�metro for valida. Deve ser colocado no OnExit do componente TDateEdit}
//function ValidaDataExit(TData: TDateEdit): boolean;
function MesAno(dData:TDateTime;bExtenso:boolean):string; //Retorna MM/YYYY ou m�s/YYYY
function InterDatas(dDt1,dDt2,dDt3,dDt4:TDate):integer;//Retorna a quantidade de dias de intersse��o entre o per�odo dDt1,dDt2 e o per�odo dDt3 e dDt4
function MyYearsBetween(dDt1,dDt2:TDateTime):integer;//Retorna a quantidade de anos entre duas datas
//function MyMonthsBetween(dData_i,dData_f:TDateTime;bPropor,bMesCalend:Boolean):Integer; // Verifica a quantidade de meses em um intervalo de datas
procedure DifDatas(dData_i,dData_f:TDateTime; var iAnos,iMeses,iDias: Integer); {Diferen�a entre datas}
function NroSemana(Data: TDateTime): shortint; //Retorna o n� da semana dentro do ano
function DataParaStoreProcedure(Data: TDate): String; //Retorna uma data no formato '01.01.1980' para ser inserida em um par�metro de uma Store Procedure, em uma senten�a SQL de uma query
function DateInBetween(ldData,ldData1,ldData2: TDate): Boolean; //Verifica se ldData est� entre ldData1 e ldData2
function DiaUtilAnterior(pConn: TFDConnection; pdData: TDate; pbSabadoUtil: Boolean = True): TDate;
function DiaUtilPosterior(pConn: TFDConnection; pdData: TDate; pbSabadoUtil: Boolean = True): TDate;
function DataExtenso(pData: TDate): String;
function DiasUteis(pdDataI,pdDataF: TDateTime; poConn: TFDConnection; pbSabadoUtil: boolean): Integer;
function StrSemBarrasToDate(psData: String): TDate; {Recebe uma data no formato 03052011 e retorna 03/05/2011}

//Array
function aSortS(sElemento:String;aArray:Array of string):Integer;overload; //Localiza um elemento dentro de uma array string
function aSortS(sElemento:String;oStrings:TStrings):Integer;overload; //Localiza um elemento dentro de um TStrings
function aSortS(sElemento:String;oStrings:TStringList):Integer;overload; //Localiza um elemento dentro de um TStrings
function aSortI(iElemento:integer;aArray:Array of integer):Integer;//Localiza um elemento dentro de um array Integer
function aSortD(dElemento:TDateTime;aArray:Array of TDateTime):Integer;//Localiza um elemento dentro de um array DateTime

//Strings
function Stuff(sString,sInsere:string;iInicio,iElimina:integer):String;// Esta fun��o modifica uma string (igual ao clipper)
function Valid_Caracter(psString: String; pbEliminaBranco: Boolean = False): String;//Substitue os caracteres n�o v�lidos.
function fSoNumeros(psString: String): String; {Retorna uma string somente com os n�meros contidos em psString, ou uma string vazia se n�o existirem n�meros em psString}
function InscMfCMasc(psInscMf,psTipo:string):string;//Retorna a InscMf com m�scara
function SubstText(sTexto, s1, s2: string): string; //Substitue todas as ocorr�ncias encontradas em um texto.
{Abrevia os nomes do meio. Ex: Andr� Luis Ribeiro da Fonte, retorna Rua Andr� L. R. da Fonte}
function AbreviaNome(sNome: String): String;
function MyCurrToStr(pdblValor: Currency; piTamanho,piDecimais: Integer;
  pbSeparadores: Boolean; pbZerosEsquerda: Boolean = true): String;
function ControleCnpj(psCnpj: String): String;
function CentraLinha(piColunaInicial,piTamLinha: Integer; psTexto: String): String; {Retorna a linha com tantos espa�os em branco necess�rios para centralizar o texto na linha}
//procedure StringListSort(var poStringList: TStringList);
//function AddInconssistencia(var poStringList: TStringList; psTexto: string; pbLinhaBranco: Boolean): Integer; {pbLinhaBranco, quando true, adiciona uma linha em branco a stringlist}
function AddStringList(var poStringList: TStringList; psTexto: string; pbLinhaBranco: Boolean): Integer; {pbLinhaBranco, quando true, adiciona uma linha em branco a stringlist}
function UpperNome(psNome: String): String; {Retorna o nome com todas as primeiras letras em mai�lculo, exceto preposi��es.}
function ValidarEMail(const psEnderecoEmail: String): Boolean;

// Outros
procedure CapsLock(State: Boolean);
procedure NumLock(State: Boolean);
//function SetFileDateTime(FileName: String; NewDateTime: TDateTime): Boolean;
//function SetFileDateTime(NomeArq: string; DataHora: TDateTime): boolean;
//function LockPessimistic(DataSet:TDataSet;sPath:string;IBDataBase:TIBDataBase;IBTransaction:TIBTransaction;sTabela:string):boolean;
Procedure fCriaFormModal(FormClasse :TComponentClass; NomeForm :TForm ); //Cria e destroi um Form Modal
function fGravaRegistro(ClienteDataSet :TClientDataSet;sTipo:String;bMsg:boolean=true):boolean; //Persiste um registro gravado ou deletado

{Executa um programa e aguarda sua finaliza��o antes de continuar
ExecAndWait com par�metro s� aceita um par�metro e
ExecCmdLineAndWait sem par�metro. Nesse caso, passar os par�metros na pr�pria
linha. Ex:
if (ExecCmdLineAndWait('D:\BD\wget.exe www.wellsoft.com.br/teste.txt -q -O D:\BD\teste.txt', SW_HIDE)) then }

function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;
function ExecCmdLineAndWait(const CmdLine: string; WindowState: Word): Boolean;

function CheckTituloEleitor(numero: String):boolean;
//procedure RdRodape(iLinha,iCol,iTamTraco:integer; psId: string = ''; pbImprimeData: Boolean = True);
procedure AtualizaStatusBar(var postBar: TStatusBar; psVersao: String; pdDataOperacao,pdDataInicio: TDate; pdAtualizaDatas: Boolean = True);
{$REGION 'BooleanToInt...'}
/// <summary>
/// Fun��o que converte um Boolean em seu respectivo valor integer
/// </summary>
/// <param name="pbBoolean">Vari�vel do tipo boolean</param>
/// <returns>Vari�vel do tipo integer</returns>
/// <remarks>
///  Fun��o mantida para retro-compatibilidade. Foi criado um Helper para o tipo
///  Boolean que implementa essa funcionalidade.
///  <c>Ex.: VarInt := VarBol.ToInteger </c>
///  <para>Changed by IJNeves 29/11/2016 16:58:06</para>
/// </remarks>
{$ENDREGION}
function BooleanToInt(pbBoolean: Boolean): Integer;
{$REGION 'IntToBoolean...'}
/// <summary>
/// Fun��o que converte um Integer em um Boolean
/// </summary>
/// <param name="piInteger">Vari�vel do tipo integer</param>
/// <returns>
///  Vari�vel do tipo Boolean onde ser� retornado <c>True</c> para os valores
///  diferentes de 0 (zero)
/// </returns>
/// <remarks>
///  Fun��o mantida para retro-compatibilidade. Apartir do Delphi XE3 foi implementado
///  na Unit System.SysUtils um Helper que implementa essa funcionalidade: TIntegerHelper.ToBoolean
/// </remarks>
{$ENDREGION}
function IntToBoolean(piInteger: Integer): Boolean;
function fEnderecoPessoa(poCdsPessoa: TClientDataSet; pTamanhoLinha: Integer): String;
procedure OrdenaDataSetGrid(var CDS: TClientDataSet; Column: TColumn; var dbgPrin: TDBGrid); {Chamar essa fun��o no evento ontitleclick do dbgrid. Ela ordena o dbgrid ao clicar na coluna.}
function IsInternetConected(): Boolean; {VErifica se est� conectado a Internet}

function EnumResTypes(hMod: THandle; ResType, ResName: PChar; Lines: TStrings):BOOL; Stdcall;
//function fContaMask(sEstrutura:String):string;
Procedure MegaContabilContaGrau(psConta,psEstruturaPlano: String;
  var poStrLstResult: TStringList);



//Forms e Edits
//Procedure fHabilita(Form: TForm);
//Procedure fDesabilita(Form: TForm);
//Procedure LimpaEdits(Form: TForm; pbSoInabilitados: Boolean = False);
//Procedure fPassaCampo(Sender: TObject; var key:Word);
{MakeRounded Fun��o que faz os componentes descendentes do TWinControl terem seus cantos
  arredondados.}
procedure MakeRounded(Control: TWinControl);

{Fun��es matem�ticas}
function Arredondar(pdblValor: Double; qtdeDecimais: Integer): Double;
function DecimalToRomano( piDecimal: LongInt ): String;
function IncValue(var value: Integer; piIncremento: Integer = 1): Integer;
function IncLongWord(var value: LongWord): LongWord;

implementation

// Create
constructor TLibMega.Create(AOwner: TComponent);
const
  bShareware: Boolean = False;
begin
  inherited Create(AOwner);
  // mensagem shareware
  if bShareware and not (csDesigning in ComponentState) then
    begin
      MessageBeep(MB_ICONASTERISK);
      MessageDlg('   O componente ' + ClassName + ' � shareware, e para ' +
        'utiliza-lo livremente' + #9#13 + '   voc� deve registra-lo.' + #13#13 +
        '    http://www.megasoftware.com.br' + #13 +
        '    mailto:megasoft@megasoftware.com.br', mtInformation, [mbOk], 0);
//      bShareware := False;
    end;
end;

//Register
procedure Register;
begin
  RegisterComponents('Megasoft', [TLibMega]);
end;

function Arredondar(pdblValor: Double; qtdeDecimais: Integer): Double;
Var
  ldblFracao, ldblTotal: Real;
  lsDecimal: String;
  liDecimal: Integer;
begin
//  try
    ldblFracao := Frac(pdblValor); {Retorna a parte fracion�ria de um n�mero}
    lsDecimal := StrRight(FloatToStr(ldblFracao),length(FloatToStr(ldblFracao))-2); {decimal recebe a parte decimal}
    {Enquanto o tamanho da variavel decimal for maior que o n�mero de casas fa�a}
    while Length(lsDecimal) > qtdeDecimais do begin
      {Verifica se o �ltimo digito da vari�vel decimal � maior que 5}
      liDecimal := 0;
      TryStrToInt(StrRight(lsDecimal,1),liDecimal);
//      if StrToInt(StrRight(lsDecimal,1))>5 then begin
      if (liDecimal > 5) then begin
        {Descarta o �ltimo digito da vari�vel Decimal}
        lsDecimal := StrLeft(lsDecimal,length(lsDecimal)-1);
        {Soma o valor n�mero da variavel decimal + 1}
        lsDecimal := FloatToStr(StrToFloat(lsDecimal) + 1);
      end else begin
        lsDecimal := StrLeft(lsDecimal,Length(lsDecimal)-1); //Descarta o �ltimo digito da vari�vel Decimal
      end;
    end;
    result := (Int(pdblValor) + (StrToFloat(lsDecimal)/100)); //devolve o resultado para a fun��o
//  except
//    Raise Exception.Create('Erro no arredondamento');
//  end;
end;


Procedure MegaContabilContaGrau(psConta,psEstruturaPlano: String;
  var poStrLstResult: TStringList);
var
  lsConta: String;
  liTamanhoConta: SmallInt;
begin
  lsConta        := fSoNumeros(psConta);
  liTamanhoConta := Length(lsConta);
  poStrLstResult.Clear;
  poStrLstResult.Add('CONTA_MASCARA='+psConta);
  poStrLstResult.Add('CONTA='+lsConta);
  poStrLstResult.Add('CONTA_ANTERIOR=');
  poStrLstResult.Add('GRAU=0');
  poStrLstResult.Add('GRAU_MAXIMO=5');
  poStrLstResult.Add('TAMANHO_CONTA='+IntToStr(liTamanhoConta));

  if (psEstruturaPlano = '9.9.9.99.999')
    or (psEstruturaPlano = '9.9.9.99.9999')
    or (psEstruturaPlano = '9.9.9.99.99999')
  then begin
    poStrLstResult.Add('GRAU1='+Copy(psConta,1,1));
    poStrLstResult.Add('GRAU2='+Copy(psConta,1,3));
    poStrLstResult.Add('GRAU3='+Copy(psConta,1,5));
    poStrLstResult.Add('GRAU4='+Copy(psConta,1,8));
    poStrLstResult.Add('GRAU5='+Copy(psConta,1,liTamanhoConta));

    if liTamanhoConta = 1 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,1);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR=';
      poStrLstResult.Strings[3] := 'GRAU=1';
    end else if liTamanhoConta = 2 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,3);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,1);
      poStrLstResult.Strings[3] := 'GRAU=2';
    end else if liTamanhoConta = 3 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,5);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,3);
      poStrLstResult.Strings[3] := 'GRAU=3';
    end else if liTamanhoConta = 5 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,8);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,5);
      poStrLstResult.Strings[3] := 'GRAU=4';
    end else if liTamanhoConta <= 10 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,liTamanhoConta);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,8);
      poStrLstResult.Strings[3] := 'GRAU=5';
    end else begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=';
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR=';
      poStrLstResult.Strings[3] := 'GRAU=0';
    end;
  end else if psEstruturaPlano = '9.9.9.99.99.99' then begin {Partidos Pol�ticos}
    poStrLstResult.Add('GRAU_MAXIMO=6');
    poStrLstResult.Add('GRAU1='+Copy(psConta,1,1));
    poStrLstResult.Add('GRAU2='+Copy(psConta,1,3));
    poStrLstResult.Add('GRAU3='+Copy(psConta,1,5));
    poStrLstResult.Add('GRAU4='+Copy(psConta,1,8));
    poStrLstResult.Add('GRAU5='+Copy(psConta,1,11));
    poStrLstResult.Add('GRAU5='+Copy(psConta,1,liTamanhoConta));
    if liTamanhoConta = 1 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,1);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR=';
      poStrLstResult.Strings[3] := 'GRAU=1';
    end else if liTamanhoConta = 2 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,3);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,1);
      poStrLstResult.Strings[3] := 'GRAU=2';
    end else if liTamanhoConta = 3 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,5);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,3);
      poStrLstResult.Strings[3] := 'GRAU=3';
    end else if liTamanhoConta = 5 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,8);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,5);
      poStrLstResult.Strings[3] := 'GRAU=4';
    end else if liTamanhoConta = 7 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,11);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,8);
      poStrLstResult.Strings[3] := 'GRAU=5';
    end else if liTamanhoConta = 9 then begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=' +Copy(psConta,1,liTamanhoConta);
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR='+Copy(psConta,1,11);
      poStrLstResult.Strings[3] := 'GRAU=6';
    end else begin
      poStrLstResult.Strings[0] := 'CONTA_MASCARA=';
      poStrLstResult.Strings[2] := 'CONTA_ANTERIOR=';
      poStrLstResult.Strings[3] := 'GRAU=0';
    end;

  end else begin
    ShowMessage('Reporte esse erro a Wellsoft: M�todo MegaContabilContaGrau - LibMega.');
    Application.Terminate;
  end;
end;


function EnumResTypes(hMod: THandle; ResType, ResName: PChar; Lines: TStrings):
  BOOL; Stdcall;
var
  MS: TMemoryStream;
  RS: TResourceStream;
  tmp,S, S2, sFormName, sCaption, sCompName, sClasse : string;
  i: Integer;
  Temp  : TStrings;
  iCont, iLin : integer;
  bTbSheet : boolean;
begin
  Result := True;
  bTbSheet := false;
  if Assigned(ResName) then begin
    Temp := TStringList.Create;
    RS := TResourceStream.Create(hinstance, ResName, ResType);
    try
      try
        MS := TMemoryStream.Create;
        try
          ObjectBinaryToText(RS, MS);
          SetLength(S, MS.Size);
          MS.Position := 0;
          MS.Read(S[1], MS.Size);
          if Pos('object', S) > 0 then begin
            Temp.Text := S;
            iLin := 0;
            for i := 0 to Temp.Count do begin
              S := Temp.Strings[i];
              if (Pos('TRDPRINT', UpperCase(S)) > 0) then begin
                Lines.add('  btnImprimir: '+'Imprimir');
                Lines.add('  btnPreview: '+'Preview');
                Continue;
              end;
              if (Pos('TDM', UpperCase(S)) > 0) or
                 (Pos('LOGIN', UpperCase(S)) > 0) or
                 (Pos('DFMPREVI', UpperCase(S)) > 0) or
                 (Pos('DFMPROGR', UpperCase(S)) > 0) or
                 (Pos('DFMSETUP', UpperCase(S)) > 0) or
                 (Pos('CALCULADORA', UpperCase(S)) > 0) or
                 (Pos('DIALOG', UpperCase(S)) > 0) then begin
                Break;
              end;
              if (i = 0) or (Pos('TBUTTON', UpperCase(S)) > 0) or (Pos('TSPEEDBUTTON', UpperCase(S)) > 0) or (Pos('TBITBTN', UpperCase(S)) > 0) or (Pos('TABSHEET', UpperCase(S)) > 0) then begin
                if (Pos('TABSHEET', UpperCase(S)) > 0) then begin
                  bTbSheet := true;
                end;
                for iCont := i+1 to Temp.Count do begin
                  S := Temp.Strings[iCont];
                  if (Pos('CALCULADORA', UpperCase(S)) > 0) then begin
                    Break;
                  end;
                  if (Pos('TABSHEET', UpperCase(S)) > 0) then begin
                    bTbSheet := true;
                  end;
                  if Pos('Caption', S) > 0 then begin
                    sCaption := Copy(S, Pos('=', S)+3, (length(S) - (Pos('=', S)+3)));
                    sCaption := StrSubst(sCaption,'&','',0);
                    sCaption := StrSubst(sCaption,quotedStr('#231'),'�',0);
                    sCaption := StrSubst(sCaption,quotedStr('#227'),'�',0);
                    sCaption := StrSubst(sCaption,quotedStr('#234'),'�',0);
                    sCaption := StrSubst(sCaption,quotedStr('#231#227'),'��',0);
                    if (i = 0) or (bTbSheet) then begin
                      Lines.add(sCaption);
                      bTbSheet := false;
                    end else begin
                      Lines.add(' '+sCaption);
                    end;
                    Break;
                  end;
                end;
              end;
            end;
          end;
        finally
          MS.Free
        end;
      except
        //
      end;
    finally
      RS.Free;
    end;
  end;
end;


//Criptografia
function Encrypt(InString: String): String;
var
  str_local, str_result: String;
begin
{$R-}
{$Q-}
  str_local  := InString;
  str_result := BinaryMethod(str_local,StartKey);
  Result := str_result;
{$R+}
{$Q+}
end;

function Decrypt(InString: String): String;
var
  str_local, str_result: String;
begin
{$R-}
{$Q-}
  str_local  := InString;
  str_result := BinaryMethod(str_local,StartKey);
  Result := str_result;
{$R+}
{$Q+}
end;

function BinaryMethod(const aText: string; aKey: word): string;
var
   nInd: Integer;
begin
   Result := aText;
   aKey := aKey shr 8;
   if aKey = 0 then
     exit;
   for nInd := 1 to length(Result) do
     Result[nInd] := char(byte(Result[nInd]) xor aKey);
end;


Function fCripto( sLinha:String ):string;
var
  sNovaLin : string;
  i : integer;
  cLetra : char;
begin
  for i := 1 to length( sLinha ) do begin
    cLetra := sLinha[i];
//    cLetra := System.Chr(System.Ord(cLetra)+102);
//    cLetra := System.Chr(System.Ord(cLetra)+35);
    cLetra := System.Chr(System.Ord(cLetra)+5);
    sNovaLin := sNovaLin + cLetra;
  end;
  result := sNovaLin;
end;

Function fDeCripto( sLinha : String ):string;
var
  sNovaLin : string;
  i : integer;
  cLetra : char;
begin
  sNovaLin := '';
  For i := 1 to Length( sLinha ) do begin
    cLetra := sLinha[i];
//    cLetra := System.Chr(System.Ord(cLetra)-102);
//    cLetra := System.Chr(System.Ord(cLetra)-35);
    cLetra := System.Chr(System.Ord(cLetra)-5);
    sNovaLin := sNovaLin + cLetra;
  end;
  result := sNovaLin;
end;

//Datas - Feriados
{*******************************************}
// CALCULO DA PASCOA
{*******************************************}
function CalculaPascoa(AAno: Word): TDateTime;
var
  R1, R2, R3, R4, R5 : Longint;
  FPascoa : TDateTime;
  VJ, VM, VD : Word;
begin
  R1 := AAno mod 19;
  R2 := AAno mod 4;
  R3 := AAno mod 7;
  R4 := (19 * R1 + 24) mod 30;
  R5 := (6 * R4 + 4 * R3 + 2 * R2 + 5) mod 7;

  FPascoa := EncodeDate(AAno, 3, 22);
  FPascoa := FPascoa + R4 + R5;

  DecodeDate(FPascoa, VJ, VM, VD);
  case VD of
    26 : FPascoa := EncodeDate(Aano, 4, 19);
    25 : if R1 > 10 then
           FPascoa := EncodeDate(AAno, 4, 18);
  end;

  Result:= FPascoa;
end;

function CalculaFeriado(AAno: Word; ATipo: TFeriados): TDate;
var
  Aux: TDate;
begin
  Aux := CalculaPascoa(AAno);
  Case ATipo of
    frCarnaval : Aux := Aux - 47;
    frQuartaCinzas : Aux := Aux - 46;
    frSextaSanta : Aux := Aux - 2;
    frCorpusChristi: Aux := Aux + 60;
  end;
  Result := Aux;
end;

function fGravaFeriados(pbAtualiza: Boolean = False): Boolean; {Grava ou atualiza a tabela com todos os feriados nacionais m�veis e fixos de 1980 a 2050}
var
  loQryFeriados: TFDQuery;
  laTipo : TFeriados;
  laAno : word;
  ldData : TDate;
  liFor : integer;
  liTransacao: LongWord;
  lbContinua: Boolean;
begin
  Result := False;
  loQryFeriados := TFDQuery.Create(nil);
  try
    lbContinua := True;
    if not pbAtualiza then begin
      loQryFeriados.Connection := TUtilConexaoFireDac.getConn;
      loQryFeriados.SQL.Append('SELECT FIRST 1 DATA FROM FERIADOS');
      loQryFeriados.Open;
      if not loQryFeriados.IsEmpty then begin
        lbContinua := False;
      end;
    end;

    if lbContinua then begin
      loQryFeriados.Close;
      loQryFeriados.SQL.Clear;
      loQryFeriados.SQL.Append('UPDATE OR INSERT INTO FERIADOS (ID_FERIADOS,DATA,DESCRICAO) VALUES(CREATEGUID(),:pData,:pDescricao) MATCHING (ID_FERIADOS)');
      liTransacao := IncLongWord(rInfoConexao.iTransacao);
      TUtil.StartTransaction(TUtil.getConn,liTransacao);

      for liFor := 1980 to 2050 do begin
        laAno := liFor;
        laTipo := frCarnaval;
        ldData := CalculaFeriado(laAno, lATipo);
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{EBB143CB-A840-43A9-9FE3-346FEDA93E97}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'CARNAVAL';
        loQryFeriados.ExecSQL;

//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{0F193AF7-BC0F-4BF9-99B4-943D4495EE9A}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData-1;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'CARNAVAL';
        loQryFeriados.ExecSQL;

        laTipo := frPascoa;
        ldData := CalculaFeriado(laAno, lATipo);
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{4B2196A0-94DB-4A2B-9B7C-8908A492FFEC}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'P�SCOA';
        loQryFeriados.ExecSQL;

        laTipo := frSextaSanta;
        ldData := CalculaFeriado(laAno, lATipo);
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{21FC94A8-F9A2-45CC-B744-53496838D6FF}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'SEXTA-FEIRA SANTA';
        loQryFeriados.ExecSQL;

        laTipo := frCorpusChristi;
        ldData := CalculaFeriado(laAno, lATipo);
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{3A21042F-4692-46CE-A9D6-A605F9C407EE}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'CORPUS CHRISTI';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('01/01/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{45C1E4C2-2466-4BC2-81BC-B884A5B8F3CB}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'DIA DA CONFRATERNIZA��O UNIVERSAL';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('21/04/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{BCC8A9F3-8944-4CF8-B3E9-FB79AF54AE99}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'TIRADENTES';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('01/05/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{A73957D6-8BF5-4A9A-8F46-7275A808CC4A}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'DIA DO TRABALHO';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('24/06/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{824D5B64-BB0B-4B29-911B-19E467A3530D}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'S�O JO�O';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('02/07/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{393ECBE2-B89B-4612-97C0-A003A52059B2}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'INDEPEND�NCIA DA BAHIA';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('07/09/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{0AA05C27-29FA-4517-98ED-61B6CA927822}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'INDEPEND�NCIA DO BRASIL';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('12/10/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{7E7DE09C-D070-4320-968E-FCB8011D7FA4}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'NOSSA SENHORA APARECIDA';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('02/11/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{229CE7D1-3616-465D-B552-12D4839E452B}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'FINADOS';
        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('15/11/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{19A5B7F3-6D88-457E-8CB8-E14D729C3847}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'PROCLAMA��O DA REP�BLICA';
        loQryFeriados.ExecSQL;

//        ldData := StrToDateTime('08/12/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{E698516D-56EC-4EA0-B0C5-F826835319C5}';
//        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
//        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'NOSSA SENHORA DA CONCEI��O';
//        loQryFeriados.ExecSQL;

        ldData := StrToDateTime('25/12/'+ IntToStr(liFor));
//        loQryFeriados.ParamByName('pIdFeriados').AsString := '{EFA3DE39-A539-4CE3-BB06-8E22CCEDA655}';
        loQryFeriados.ParamByName('pData'      ).AsDate   := ldData;
        loQryFeriados.ParamByName('pDescricao'      ).AsString := 'NATAL';
        loQryFeriados.ExecSQL;
      end;
      TUtil.Commit(TUtil.getConn,liTransacao);
    end;
  finally
    FreeAndNil(loQryFeriados);
  end;
end;




function AcrescMinutos(dData:TDateTime;iMinutos:integer):TDateTime;//Acrescenta N minutos a uma dataHora
//var
  {
  H, Mi, S, N: Word;
  D, M, Y: Word;
  bAcrescentaDia : boolean;
  }
begin
  Result := dData + StrToTime('00:'+StrZero(iMinutos,2,0)+':00');
  {
  decodeDate(dData,Y,M,D);
  decodeTime(dData,H,Mi,S,N);
  Mi := Mi + 15;
  bAcrescentaDia := false;
  if Mi > 60 then begin
    Mi := Mi-60;
    H := H+1;
    if H > 23 then begin
      H := 00;
      bAcrescentaDia := true;
    end;
  end;
  dDtNovaData := EncodeDate(Y,M,D)+EncodeTime(H,Mi,S,N);
  if bAcrescentaDia then begin
    dDtNovaData := dDtNovaData + 1;
  end;
  }
end;

function IncDecAnos(pdData:TDateTime; piAnos:integer):TDateTime;//Incrementa ou decrementa anos a uma data (Se iAnos for positivo incremento, negativa decrementa)
//var
//  wDia, wMes, wAno : Word;
begin
//  decodeDate(pdData,wAno,wMes,wDia);
//  wAno := wAno+piAnos;
//  if (DateStr(pdData,dtsDM) = '2902') and (not IsLeapYear(wAno)) then begin
//    {Se o dia/m�s de pdData � 29/02 e o ano depois de incrementado por piAnos
//    n�o � bissexto, diminui um dia de wDia para ficar 28/02/}
//    Dec(wDia);
//  end;
//  Result := EncodeDate(wAno,wMes,wDia);
  Result := TUtilMath.IncDecAnos(pdData,piAnos);
end;

//Incrementa meses
function IncDecMes(dData:TDateTime;iTempo:Integer):TDateTime;
//var
//  iDia, iMes, iAno, iFor, iUltDia : integer;
//  lsData: String;
begin
//  Result := dData;
//  iDia := Day(dData);
//  iMes := Month(dData);
//  iAno := Year(dData);
//  if iTempo > 0 Then begin
//    for iFor := 1 to iTempo do begin
//      inc(iMes);
//      if iMes = 13 then begin
//         iMes := 1;
//         inc(iAno);
//      end;
//    end;
//  end else begin
//    for iFor := abs(iTempo) downto 1 do begin
//      dec(iMes);
//      if iMes = 0 then begin
//         iMes := 12;
//         dec(iAno);
//      end;
//    end;
//  end;
//  iUltDia := DaysInMonth(iMes,iAno);
//  if iDia > iUltDia then begin
//    iDia := iUltDia;
//  end;
//  try
//    Result := StrToDateTime(StrZero(iDia,2,0)+'/'+StrZero(iMes,2,0)+'/'+StrZero(iAno,4,0));
//  except
//    Result := 0;
//  end;
//
//  lsData := StrZero(iDia,2,0)+'/'+StrZero(iMes,2,0)+'/'+StrZero(iAno,4,0);
//  Result := 0;
//  TryStrToDateTime(lsData,Result);
  Result := TUtilMath.IncDecMes(dData,iTempo);
end;



function ValidaData(TData: TEvMonthYear; pbOnExit: Boolean = True): Boolean;overload;
var
  MsgDlg1 : TEvMsgDlg;
  ldData: TDateTime;
begin
  Result := False;
  if (Trim(Copy(TData.Text,1,2)+Copy(TData.Text,7,4)) <> '')
    and ((pbOnExit)
    or (Length(fSoNumeros(TData.Text)) = 6))
  then begin
    if (Length(fSoNumeros(TData.Text)) = 6) then begin
      ldData := 0;
      if (not TryStrToDate('01/'+TData.Text,ldData)) then begin
        MsgDlg1 := TEvMsgDlg.Create(nil);
        try
          MsgDlg1.MsgError('A data '+TData.Text+' n�o � v�lida.');
//          TData.DateValue := TP_DATA_EMPTY;
        finally
          FreeAndNil(MsgDlg1);
        end;
        if TData.CanFocus then begin
          TData.SetFocus;
          TData.SelStart := 0;
        end;
      end else begin
        Result := True;
      end;
      Exit;
    end;
  end;
end;


function MesAno(dData:TDateTime;bExtenso:boolean):string; //Retorna MM/YYYY ou m�s/YYYY
var
  sMesAno, sMesExtenso : string;
begin
  if (dData <> TP_DATA_EMPTY) then begin
    sMesAno := DateStr(dData,dtsMY);
    if not bExtenso then begin
      sMesAno := Copy(sMesAno,1,2)+'/'+Copy(sMesAno,3,4);
    end else begin
      sMesExtenso := FirstUpper(MonthName(dData));
      sMesAno := sMesExtenso+'/'+Copy(sMesAno,3,4);
    end;
    Result := sMesAno;
  end else begin
    Result := '';
  end;
end;

function MyYearsBetween(dDt1,dDt2:TDateTime):integer;//Retorna a quantidade de anos entre duas datas
var
  bBissexto : boolean;
begin
  {Acrescenta 1 dia a data final, pois, caso contr�rio, ao incrementar o ano
   dDt1 ficaria maior que dDt2 e, com isso, n�o incrementaria o resultado
   dessa fun��o.

   Exemplo se n�o incrementasse 1 dia a data final:
   Data Inicial = 01.01.2010
   Data Final = 31.12.2010
   Data Inicial incrementata em um ano = 01.01.2011
   Como a data inicial, ap�s o incremento de 1 ano ultrapassou a data final,
   essa fun��o n�o incrementa o resultado da quantidade de anos.

   Exemplo incrementando 1 dia a data final:
   Data Inicial = 01.01.2010
   Data Final = 31.12.2010
   Data Final incrementada em um dia = 01.01.2011
   Data Inicial incrementata em um ano = 01.01.2011
   Como a data inicial, ap�s o incremento de 1 ano � menor igual a data final,
   essa fun��o incrementa o resultado da quantidade de anos. Retornando com isso
   a quantidade de anos entre duas datas corretamente.
   }
  dDt2 := dDt2+1;
  {Se a data for 29 de fevereiro}
  if (day(dDt1) = 29) and (month(dDt1) = 2) then begin
    bBissexto := true;
    dDt1 := dDt1-1; //Diminue um dia para n�o dar erro na fun��o IncDecAnos
  end else begin
    bBissexto := false;
  end;
  Result := 0;
  while dDt1 <= dDt2 do begin
    {Se dDt1 for 29 de fevereiro, diminue um dia para n�o dar erro na
    fun��o IncDecAnos}
    if (day(dDt1) = 29) and (month(dDt1) = 2) then begin
      dDt1 := dDt1-1;
    end;
    {Incrementa 1 ano}
    dDt1 := IncDecAnos(dDt1,1);
    {Se a data inicial era 29 de fevereiro e o ano atual de dDt1 �
    bissexto, retorna dDt1 para 29 de fevereiro}
    if (bBissexto) and (IsLeapYear(year(dDt1))) then begin
      dDt1 := EndOfMonth(dDt1);
    end;
    {Compara para ver se ainda � necess�rio incrementar o contador de anos}
    if dDt1 <= dDt2 then begin
      inc(Result);
    end;
  end;
end;

procedure DifDatas(dData_i,dData_f:TDateTime; var iAnos,iMeses,iDias: Integer); {Diferen�a entre datas}
var
  dData: TDate;
begin
  iAnos := MyYearsBetween(dData_i,dData_f);
  dData := IncDecAnos(dData_i,iAnos);
  //iMeses := MyMonthsBetween(dData,dData_f,false,false);
  dData := IncDecMes(dData,iMeses);
  iDias := Trunc((dData_f-dData)+1);
end;

function NroSemana(Data: TDateTime): shortint; //Retorna o n� da semana dentro do ano
var
  dt1: TDateTime;
  dif: integer;
begin
  dt1:=StrtoDate('01/01/'+
   FormatDateTime('yyyy',Data)); // Primeiro dia do ano
  dt1:=dt1-DayofWeek(dt1); // �ltimo s�bado do ano anterior
  dif:=trunc(Data-dt1);
  Result:=((dif-1) div 7)+1;
end;

function DataParaStoreProcedure(Data: TDate): String; //Retorna uma data no formato '01.01.1980' para ser inserida em um par�metro de uma Store Procedure, em uma senten�a SQL de uma query
begin
  result := quotedStr(StrZero(Day(Data),2,0)+'.'+StrZero(Month(Data),2,0)+'.'+StrZero(year(Data),4,0));
end;

function InterDatas(dDt1,dDt2,dDt3,dDt4:TDate):integer;//Retorna a quantidade de dias de intersse��o entre o per�odo dDt1,dDt2 e o per�odo dDt3 e dDt4
var
  dDataInicial, dDataFinal:TDate;
begin
  Result := 0;
  if (dDt1 <= dDt2) and (dDt3 <= dDt4) and ((dDt1 <= dDt4) and (dDt2 >= dDt3)) then begin
    if (dDt1 > dDt3) then begin
      dDataInicial := dDt1;
    end else begin
      dDataInicial := dDt3;
    end;
    if (dDt2 < dDt4) then begin
      dDataFinal := dDt2;
    end else begin
      dDataFinal := dDt4;
    end;
  end;
end;

function DateInBetween(ldData,ldData1,ldData2: TDate): Boolean; //Verifica se ldData est� entre ldData1 e ldData2
begin
  Result := false;
  if ldData1 < ldData2 then begin
    if (ldData >= ldData1) and (ldData <= ldData2) then begin
      Result := true;
    end;
  end else begin
    if (ldData >= ldData2) and (ldData <= ldData1) then begin
      Result := true;
    end;
  end;
end;

function DiaUtilAnterior(pConn: TFDConnection; pdData: TDate; pbSabadoUtil: Boolean = True): TDate;
var
  loQryFeriados: TFDQuery;
  lbFeriado: Boolean;
begin
  loQryFeriados := TFDQuery.Create(nil);
  try
    loQryFeriados.Connection := pConn;
    loQryFeriados.SQL.Add('SELECT DATA FROM FERIADOS');
    loQryFeriados.Open;
    if (not pbSabadoUtil) and (DayOfWeek(pdData) = 7) then begin
      pdData := pdData - 1;
    end else if DayOfWeek(pdData) = 1 then begin
      pdData := pdData - 2;
    end;
    lbFeriado := true;
    while lbFeriado do begin
      if not loQryFeriados.Locate('DATA',pdData,[]) then begin
        lbFeriado := false;
      end else begin
        pdData := pdData-1;
      end;
    end;
    Result := pdData;
  finally
    FreeAndNil(loQryFeriados);
  end;
end;

function DiaUtilPosterior(pConn: TFDConnection; pdData: TDate; pbSabadoUtil: Boolean = True): TDate;
var
  loQryFeriados: TFDQuery;
  lbFeriado: Boolean;
begin
  loQryFeriados := TFDQuery.Create(nil);
  try
    loQryFeriados.Connection := pConn;
    loQryFeriados.SQL.Add('SELECT DATA FROM FERIADOS');
    loQryFeriados.Open;
    lbFeriado := true;
    while lbFeriado do begin
      if not loQryFeriados.Locate('DATA',pdData,[]) then begin
        lbFeriado := false;
      end else begin
        pdData := pdData+1;
      end;
    end;
    if (not pbSabadoUtil) and (DayOfWeek(pdData) = 7) then begin
      pdData := pdData + 2;
    end else if DayOfWeek(pdData) = 1 then begin
      pdData := pdData + 1;
    end;
    Result := pdData;
  finally
    FreeAndNil(loQryFeriados);
  end;
end;

function DataExtenso(pData: TDate): String;
begin
  Result := StrZero(Day(pData),2,0)+' de '+MonthName(pData)+' de '+StrZero(Year(pData),4,0);
end;

function StrSemBarrasToDate(psData: String): TDate; {Recebe uma data no formato 03052011 e retorna 03/05/2011}
var
 ldData: TDateTime;
begin
//  Result := StrToDate(Copy(psData,1,2)+'/'+Copy(psData,3,2)+'/'+Copy(psData,5,4));
  ldData := 0;
  TryStrToDate(Copy(psData,1,2)+'/'+Copy(psData,3,2)+'/'+Copy(psData,5,4),ldData);
  Result := ldData;
end;


function DiasUteis(pdDataI,pdDataF: TDateTime; poConn: TFDConnection;
  pbSabadoUtil: boolean): Integer;
var
 liFeriados: Integer;
begin
  Result := 0;

  while (pdDataI <= pdDataF) do begin
    if ((not pbSabadoUtil) and (DayOfWeek(pdDataI) <> 1) and (DayOfWeek(pdDataI) <> 7)) then begin
      Inc(Result);
    end else if ((pbSabadoUtil) and (DayOfWeek(pdDataI) <> 7)) then begin
      Inc(Result);
    end;
    pdDataI := pdDataI+1;
  end;
  Result := Result-QtdeferiadosPeriodo(pdDataI,pdDataF,poConn,pbSabadoUtil);
  if Result < 0 then begin
    Result := 0;
  end;
end;

function QtdeferiadosPeriodo(pdDataI,pdDataF: TDateTime; poConn: TFDConnection;
  pbSabadoUtil: boolean): Integer;
var
  loQryFeriados: TFDQuery;
begin
  Result := 0;
  loQryFeriados := TFDQuery.Create(nil);
  try
    loQryFeriados.Connection := poConn;
    {Seleciona os f�riados no intervalo de datas, exceto os f�riados aos
     domingos}
    loQryFeriados.SQL.Add('SELECT count(F.ID_FERIADOS) AS QTDE FROM FERIADOS F WHERE (F.DATA BETWEEN :pDataInicial AND :pDataFinal) AND (EXTRACT(WEEKDAY FROM F.DATA) <> 0)');
    if not pbSabadoUtil then begin
      {Se o s�bado n�o � �til, n�o computa os f�riados no s�bado.}
      loQryFeriados.SQL.Add(' AND (EXTRACT(WEEKDAY FROM F.DATA) <> 6)');
    end;
    loQryFeriados.ParamByName('pDataInicial').AsDate := pdDataI;
    loQryFeriados.ParamByName('pDataFinal'  ).AsDate := pdDataF;
    loQryFeriados.Open;
    Result := loQryFeriados.FieldByName('QTDE').AsInteger;
  finally
    FreeAndNil(loQryFeriados);
  end;
end;

//Arrays
function aSortS(sElemento:String;aArray:Array of string):Integer;overload;//Localiza um elemento dentro de um array string
var
  iFor : integer;
begin
  result := -1;
  for iFor := low(aArray) to high(aArray) do begin
    if sElemento = aArray[iFor] then begin
      result := iFor;
      break;
    end;
  end;
end;

function aSortS(sElemento:String;oStrings: TStrings):Integer; overload;//Localiza um elemento dentro de um TStrings
var
  iFor : integer;
begin
  result := -1;
//  for iFor := low(oStrings) to high(oStrings) do begin
  for iFor := 0 to oStrings.Count-1 do begin
    if sElemento = oStrings[iFor] then begin
      result := iFor;
      break;
    end;
  end;
end;

function aSortS(sElemento:String;oStrings: TStringList):Integer; overload;//Localiza um elemento dentro de um TStringList
var
  iFor : integer;
begin
  result := -1;
  for iFor := 0 to oStrings.Count-1 do begin
    if sElemento = oStrings.Strings[iFor] then begin
      result := iFor;
      break;
    end;
  end;
end;


function aSortI(iElemento:integer;aArray:Array of integer):Integer;//Localiza um elemento dentro de um array Integer
var
  iFor : integer;
begin
  result := -1;
  for iFor := low(aArray) to high(aArray) do begin
    if iElemento = aArray[iFor] then begin
      result := iFor;
      break;
    end;
  end;
end;

function aSortD(dElemento:TDateTime;aArray:Array of TDateTime):Integer;//Localiza um elemento dentro de um array DateTime
var
  iFor : integer;
begin
  result := -1;
  for iFor := low(aArray) to high(aArray) do begin
    if dElemento = aArray[iFor] then begin
      result := iFor;
      break;
    end;
  end;
end;

//Strings
function Stuff(sString,sInsere:string;iInicio,iElimina:integer):String;// Esta fun��o modifica uma string (igual ao clipper)
var
  sNovaString, sPrimParte, sSegParte : string;
begin
  if iInicio = 1 then begin
    sPrimParte := '';
  end else if iInicio >= 2 then begin
    sPrimParte := Copy(sString,1,iInicio-1);
  end;
  sSegParte  := Copy(sString,iInicio,Length(sString)-Length(sPrimParte));
  if iElimina > 0 then begin
    sSegParte := Copy(sSegParte,iElimina+1,Length(sSegParte)-iElimina);
  end;
  if Length( sInsere ) > 0 then begin
    sNovaString := sPrimParte + sInsere + sSegParte;
  end else begin
    sNovaString := sPrimParte + sSegParte;
  end;
  Stuff := Trim(sNovaString);
end;

function Valid_Caracter(psString: String; pbEliminaBranco: Boolean = False): String;//Substitue os caracteres n�o v�lidos para cria��o de arquivo.
//var
//   sAcentos1, sAcentos2 : String;
//   iFor, iAux : Integer;
begin
//  sAcentos1 := '����� ����� ����� �� ������ ����� ����� ����� �� ������ �窺!@#$%^&*()_+-=[]\{}|:";<>?,./�';
//  sAcentos2 := 'AIOUE AIOUE AIOUE AO AIOUEN aioue aioue aioue ao aiouen Ccao                              ';
//  for iFor := 1 to Length(psString) do begin
//    iAux := Pos(psString[iFor], sAcentos1);
//    if (iAux > 0) then begin
//      psString[iFor] := sAcentos2[iAux];
//    end;
//  end;
//  Result := psString;
//  if pbEliminaBranco then begin
//    Result := SubstText(psString,' ','');
//  end;
//  {Retira os caracteres de controle}
//  Result := TRegEx.Replace(Result, '[[:cntrl:]]',''); {utiliza��o da classe POSIX [[:cntrl:]]}
  {Valid_Caracter foi mantita por quest�o de compatibilidade. Assim que poss�vel,
  Trocar para TUtilFormat.ValidCaracter}
  Result := TUtilFormat.ValidCaracter(psString,pbEliminaBranco);
end;

function fSoNumeros(psString: string): string;
begin
//  {$IFDEF VER230}
   {TRegEx precisa da declara��o em uses de
    System.RegularExpressions}
   // Result := TRegEx.Replace(psString, '\D','');
//  {$ENDIF}
end;

//function fSoNumeros(sString:string):string;//Retorna uma string sem m�scaras
//var
//  iFor : integer;
//  sNovaString, sNumeros : string;
//begin
//  sNumeros := '0123456789';
//  sNovaString := '';
//  for iFor := 1 to Length(sString) do begin
//    if Pos(sString[iFor],sNumeros) > 0 then begin
//      sNovaString := sNovaString + sString[iFor];
//    end;
//  end;
//  Result := sNovaString;
//end;

function InscMfCMasc(psInscMf,psTipo:string):string;//Retorna a InscMf com m�scara
begin
//  psInscMf := fSoNumeros(psInscMf);
//  if Trim(psTipo) = 'CNPJ' then begin
//    psInscMf := StrZero(StrToInt64(psInscMf),TAMANHO_CNPJ_SEM_MASCARA,0);
//    psInscMf := Copy(psInscMf,1,2) + '.' + Copy(psInscMf,3,3) + '.' + Copy(psInscMf,6,3) + '/' + Copy(psInscMf,9,4) + '-' + Copy(psInscMf,13,2);
//  end else if Trim(psTipo) = 'CPF' then begin
//    psInscMf := StrZero(StrToInt64(psInscMf),TAMANHO_CPF_SEM_MASCARA,0);
//    psInscMf := Copy(psInscMf,1,3) + '.' + Copy(psInscMf,4,3) + '.' + Copy(psInscMf,7,3) + '-' + Copy(psInscMf,10,2);
//  end else if Trim(psTipo) = 'CEI' then begin
//    psInscMf := StrZero(StrToInt64(psInscMf),TAMANHO_CEI_SEM_MASCARA,0);
//    psInscMf := Copy(psInscMf,1,2) + '.' + Copy(psInscMf,3,3) + '.' + Copy(psInscMf,6,2) + '.' + Copy(psInscMf,8,3) + '/' + Copy(psInscMf,11,2);
//  end;
//  Result := psInscMf;

  Result := TUtilFormat.InscMfCMasc(psInscMf,psTipo);
end;


function SubstText(sTexto, s1, s2: string): string;
begin
  result := '';
  while Pos(s1,sTexto) > 0 do begin
    result := result + Copy(sTexto,1,Pos(s1,sTexto)-1) + s2;
    Delete(sTexto,1,Pos(s1,sTexto)+Length(s1)-1);
  end;
  result := result + sTexto;
end;

function AbreviaNome(sNome: String): String;
var
 sNomes : array[1..20] of string;
 iPos, iFor, iTotalNomes : Integer;
begin
  {Insere um espa�o para garantir que todas as letras sejam testadas}
  sNome := Trim(sNome);
  Result := sNome;
  {Pega a posi��o do primeiro espa�o}
  sNome := sNome + #32;
  iPos := Pos(#32, sNome);
  if iPos > 0 then begin
    iTotalNomes := 0;
    {Separa todos os nomes}
    while iPos > 0 do begin
      Inc(iTotalNomes);
      sNomes[iTotalNomes] := Copy(sNome, 1, iPos - 1);
      Delete(sNome, 1, iPos);
      iPos := Pos(#32, sNome);
    end;
    if iTotalNomes > 2 then begin
      {Abreviar a partir do segundo nome, exceto o �ltimo.}
      for iFor := 2 to iTotalNomes - 1 do begin
        {Cont�m mais de 3 letras? (ignorar de, da, das, do, dos, etc.)}
        if Length(sNomes[iFor]) > 3 then begin
          {Pega apenas a primeira letra do nome e coloca um ponto ap�s.}
          sNomes[iFor] := sNomes[iFor][1] + '.';
        end;
      end;
      Result := '';
      for iFor := 1 to iTotalNomes do begin
        Result := Result + Trim(sNomes[iFor]) + #32;
      end;
      Result := Trim(Result);
    end;
  end;
end;

function MyCurrToStr(pdblValor: Currency; piTamanho,piDecimais: Integer;
  pbSeparadores: Boolean; pbZerosEsquerda: Boolean = true): String;
var
  liPos,liParteInteira,liParteDecimal,liFor,liTamanho: Integer;
  lsValor,lsParteInteira,lsParteDecimal,lsDecimalSeparador: string;
begin
  Result := '';
  lsParteInteira := '';
  lsParteDecimal := '';

  if pbSeparadores then begin
    lsDecimalSeparador := FormatSettings.DecimalSeparator;
    liTamanho := piTamanho;
  end else begin
    lsDecimalSeparador := '';
    liTamanho := piTamanho+1;
  end;

  lsValor := strzero(pdblValor,liTamanho,piDecimais);
  lsValor := StrSubst(lsValor,'.',',',0);
  liPos   := Pos(',',lsValor);

  if liPos <> 0 then begin
    lsParteInteira := copy(lsValor,1,liPos-1);
    if piDecimais > 0 then begin
      lsParteDecimal := Copy(lsValor,liPos+1,piDecimais);
      while Length(lsParteDecimal) < piDecimais do begin
        lsParteDecimal := lsParteDecimal+'0';
      end;
    end;
  end else begin
    lsParteInteira := lsValor;
    if piDecimais > 0 then begin
      while Length(lsParteDecimal) < piDecimais do begin
        lsParteDecimal := lsParteDecimal+'0';
      end;
    end;
  end;

  Result := lsParteInteira+lsDecimalSeparador+lsParteDecimal;

  if (not pbZerosEsquerda) then begin
    {Retira os zeros a esquerda}
    while (Copy(Result,1,1) = '0') do begin
      Result := StrSubst(Result,'0','',1);
    end;
  end;

end;

{Retorna o controle do CNPJ. Ex: 14.008.828/0003-84,
 Retorna 0003}
function ControleCnpj(psCnpj: String): String;
begin
  Result := copy(psCnpj,12,4);
end;

function CentraLinha(piColunaInicial,piTamLinha: Integer; psTexto: String): String; {Retorna a linha com tantos espa�os em branco necess�rios para centralizar o texto na linha}
var
  liColuna: Integer;
begin
  liColuna := Trunc((piTamLinha-(piColunaInicial+Length(psTexto)))/2);
  psTexto  := StrSpace(liColuna-1)+trim(psTexto);
end;

//procedure StringListSort(var poStringList: TStringList);
//var
//  liFor,liFor1: Longword;
//  lsItem: String;
//begin
//  for liFor := 0 to poStringList.Count-1 do begin
//    for liFor1 := liFor+1 to poStringList.Count-1 do begin
//      if StrToInt(fSoNumeros(poStringList.Strings[liFor])) > StrToInt(FSoNumeros(poStringList.Strings[liFor1])) then begin
//        lsItem := poStringList.Strings[liFor];
//        poStringList.Strings[liFor]  := poStringList.Strings[liFor1];
//        poStringList.Strings[liFor1] := lsItem;
//      end;
//    end;
//  end;
//end;

function AddStringList(var poStringList: TStringList; psTexto: string; pbLinhaBranco: Boolean): Integer; {pbLinhaBranco, quando true, adiciona uma linha em branco a stringlist}
begin
  Result := -1;
  if poStringList.IndexOf(psTexto) < 0 then begin
    Result := poStringList.Add(psTexto);
    if pbLinhaBranco then begin
      poStringList.Add(' ');
    end;
  end;
end;

function UpperNome(psNome: String): String;
var
	liFor: Integer;
	lista: Array[0..4] of String[03];

  function NaoAchaPreposicao(Palavra : String): Boolean;
  var
 	  liFor: Integer;
  begin
	  Result := True;
	  for liFor := 0 to 4 do begin
		  if Trim(Palavra) = lista[liFor] then begin
			  Result := False;
		  end;
	  end;
  end;
begin
  psNome := AnsiLowerCase(psNome);
	Result := psNome;
	lista[0] := 'das';
  lista[1] := 'dos' ;
	lista[2] := 'de';
  lista[3] := 'do' ;
	lista[4] := 'da';
	Result := UpCase(Result[1]) + Copy(Result, 2, Length(Result));
	for liFor := 2 to Length(psNome) do begin
		if (psNome[liFor] = #32) then begin
			if (Copy(psNome,liFor+1,1) <> 'e') then begin
				if (NaoAchaPreposicao(Copy(psNome,liFor+1,3))) then begin
					Result := Copy(Result, 1, liFor) + UpCase(Result[liFor+1]) + Copy(Result, liFor+2, Length(Result));
				end;
			end;
		end;
	end;
end;

//Leia mais em: Function para validar Email http://www.devmedia.com.br/function-para-validar-email/16012#ixzz28vLPCbml
//function ValidarEMail(psEnderecoEmail: string): Boolean;
//begin
// psEnderecoEmail := Trim(UpperCase(psEnderecoEmail));
//
// if Pos('@', psEnderecoEmail) > 1 then begin
//   Delete(psEnderecoEmail, 1, pos('@', psEnderecoEmail));
//   Result := (Length(psEnderecoEmail) > 0) and (Pos('.', psEnderecoEmail) > 2);
// end else begin
//   Result := False;
// end;
//end;

function ValidarEMail(const psEnderecoEmail: String): Boolean;
const
  CaraEsp: array[1..40] of string[1] =
  ( '!','#','$','%','�','&','*',
  '(',')','+','=','�','�','�','�','�',
  '�','�','�','`','�','�',',',';',':',
  '<','>','~','^','?','/','','|','[',']','{','}',
  '�','�','�');
var
  liFor,liCont   : integer;
  lsEnderecoEmail    : ShortString;
begin
  lsEnderecoEmail := psEnderecoEmail;
  Result := True;
  liCont := 0;
  if lsEnderecoEmail <> '' then begin
    if (Pos('@', lsEnderecoEmail)<>0) and (Pos('.', lsEnderecoEmail)<>0) then begin  {existe @ .}
      if (Pos('@', lsEnderecoEmail)=1)
        or (Pos('@', lsEnderecoEmail)= Length(lsEnderecoEmail))
        or (Pos('.', lsEnderecoEmail)=1)
        or (Pos('.', lsEnderecoEmail)= Length(lsEnderecoEmail))
        or (Pos(' ', lsEnderecoEmail)<>0)
      then begin
        Result := False
      end else begin  {@ seguido de . e vice-versa}
        if (abs(Pos('@', lsEnderecoEmail) - Pos('.', lsEnderecoEmail)) = 1) then begin
          Result := False
        end else begin
          for liFor := 1 to 40 do begin {se existe Caracter Especial}
            if Pos(CaraEsp[liFor], lsEnderecoEmail)<>0 then begin
              Result := False;
            end;
          end;
          for liFor := 1 to length(lsEnderecoEmail) do begin {se existe apenas 1 @}
            if lsEnderecoEmail[liFor] = '@' then begin
              liCont := liCont + 1; {. seguidos de .}
            end;
            if (lsEnderecoEmail[liFor] = '.') and (lsEnderecoEmail[liFor+1] = '.') then begin
              Result := false;
            end;
          end;
          {. no f, 2ou+ @, . no i, - no i, _ no i}
          if (liCont >=2)
            or ( lsEnderecoEmail[length(lsEnderecoEmail)]= '.' )
            or ( lsEnderecoEmail[1]= '.' ) or ( lsEnderecoEmail[1]= '_' )
            or ( lsEnderecoEmail[1]= '-' )
          then begin
            Result := false;
          end;
          {@ seguido de COM e vice-versa}
          if (abs(Pos('@', lsEnderecoEmail) - Pos('com', lsEnderecoEmail)) = 1) then begin
            Result := False;
          end;
          {@ seguido de - e vice-versa}
          if (abs(Pos('@', lsEnderecoEmail) - Pos('-', lsEnderecoEmail)) = 1) then begin
            Result := False;
          end;
          {@ seguido de _ e vice-versa}
          if (abs(Pos('@', lsEnderecoEmail) - Pos('_', lsEnderecoEmail)) = 1) then begin
            Result := False;
          end;
        end;
      end;
    end else begin
      Result := False;
    end;
  end;
end;



//procedure CapsOnOff(State: Boolean);
procedure CapsLock(State: Boolean);
begin
  if (State and ((GetKeyState(VK_CAPITAL) and 1) = 0)) or
     ((not State) and ((GetKeyState(VK_CAPITAL) and 1) = 1)) then begin
    KeyBd_Event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
    KeyBd_Event(VK_CAPITAL, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
  end;
end;

procedure NumLock(State: Boolean);
begin
  if (State and ((GetKeyState(VK_NUMLOCK) and 1) = 0)) or
     ((not State) and ((GetKeyState(VK_NUMLOCK) and 1) = 1)) then begin
    KeyBd_Event(VK_NUMLOCK, $45, KEYEVENTF_EXTENDEDKEY or 0, 0);
    KeyBd_Event(VK_NUMLOCK, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);
  end;
end;

function fGravaRegistro(ClienteDataSet :TClientDataSet;sTipo:String;bMsg:boolean=true):boolean;
begin
  Result := false;
  if UpperCase(sTipo) = 'POST' then begin
    ClienteDataSet.Post;
  end else begin
    ClienteDataSet.Delete;
  end;
  if ClienteDataSet.ApplyUpdates(0) <> 0 then begin
    ClienteDataSet.Cancel;
    ClienteDataSet.CancelUpdates;
    if bMsg then begin //Se deve mostrar mensagen
      if UpperCase(sTipo) = 'POST' then begin
        showmessage('Problema na grava��o. Registro n�o gravado');
      end else begin
        showmessage('Problema na exclus�o. Registro n�o exclu�do');
      end;
    end;
    Result := false;
  end else begin
    ClienteDataSet.Close;
    ClienteDataSet.Open;
    if bMsg then begin //Se deve mostrar mensagen
      if UpperCase(sTipo) = 'POST' then begin
        showmessage('Registro gravado.');
      end else begin
        showmessage('Registro exclu�do.');
      end;
    end;
    Result := true;
  end;

end;


Procedure fCriaFormModal(FormClasse :TComponentClass; NomeForm :TForm );
begin
  Application.CreateForm(FormClasse,NomeForm);
  try
    NomeForm.ShowModal;
  finally
//    NomeForm.Release;
//    NomeForm := nil;
    FreeAndNil(NomeForm);
  end;
end;

procedure MakeRounded(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do begin
   R := ClientRect;
   rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
   Perform(EM_GETRECT, 0, lParam(@r));
   InflateRect(r, - 5, - 5);
   Perform(EM_SETRECTNP, 0, lParam(@r));
   SetWindowRgn(Handle, rgn, True);
   Invalidate;
  end;
end;


function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  { Coloca o nome do arquivo entre aspas. Isto � necess�rio devido aos espa�os contidos em nomes longos }
//  CmdLine := '"' + trim(Filename) + '" "' + trim(Params) + '"';
  CmdLine := '"' + trim(Filename) + '" ' + trim(Params);
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
  CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS, nil,
  PChar(ExtractFilePath(Filename)), SUInfo, ProcInfo);
  { Aguarda at� ser finalizado }
  if Result then begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Libera os Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

{*------------------------------------------------------------------------------
  Execute a complete shell command line and waits until terminated.

  @param CmdLine
  @param WindowState
  @return
  @source: http://www.swissdelphicenter.ch/torry/showcode.php?id=455
--------------------------------------------------------------------------------}
function ExecCmdLineAndWait(const CmdLine: string; WindowState: Word): Boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
begin
  { Enclose filename in quotes to take care of long filenames with spaces. }
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(
    nil,
    PChar(CmdLine),
    nil,
    nil,
    False,
    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
    nil,
    nil, //PChar(ExtractFilePath(Filename))
    SUInfo,
    ProcInfo);
  //Wait for it to finish.
  if Result then begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  end;
end;


function CheckTituloEleitor(numero: String): Boolean;
var
  intInd1,intInd2,intLimite    : Integer;
  intSoma,intDigito            : Integer;
  strDVc,strSequencial         : String;
  strUF,strDV1,strDV2          : String;
begin
  numero := Trim(numero);
  while (Length(numero) < 13) do begin
    numero := '0' + numero;
  end;
  intInd1 := 0;
  intInd2 := 0;
  strDVc  := '';
  strSequencial := Copy(numero,1,9);
  strUF         := Copy(numero,10,2);
  strDV1        := Copy(numero,12,1);
  strDV2        := Copy(numero,13,1);
  {Verifca se a UF estiver entre os c�digo poss�veis, de 1(SP) at� 28(ZZ-Exterior)}
  if ((StrToInt(strUF) >  0) and (StrToInt(strUF) < 29)) then begin
    intLimite := 9;
    {Loop para calcular os 2 d�gitos verificadores}
    for intInd1 := 1 to 2 do begin
      intSoma := 0;
      {Calcula a soma para submeter ao m�dulo 11}
      for intInd2 := 1 to intLimite do begin
       intSoma := intSoma + StrToInt(Copy(strSequencial,intInd2,1)) * (intLimite + 2 - intInd2);
      end;
      {Pega o resto da d�vis�o, o m�dulo, por 11}
      intDigito := intSoma mod 11;
      { Se a UF for SP ou MG}
      if  (StrToInt(strUF) in [1,2]) then begin
        if (intDigito = 1) then begin
          intDigito := 0
        end else if (intDigito = 0) then begin
          intDigito := 1
        end else begin
          intDigito := 11 - intDigito;
        end;
      end else begin
        {Outros UF e Exterior}
        if ((intDigito = 1) or (intDigito = 0)) then begin
          intDigito := 0
        end else begin
          intDigito := 11 - intDigito;
        end;
      end;
      {Atribui � variavel strDVc o d�gito calculado}
      strDVc := strDVc + IntToStr(intDigito);
      {Muda o valor de intLimite para o c�culo do segundo d�gito}
      intLimite:= 3;
      {O c�lculo do segundo d�gito ser� sobre o c�digo da UF + primeiro d�gito verificador}
      strSequencial:= strUF + IntToStr(intDigito);
    end;
  end;
  result := (strDV1+strDV2 = strDVc);
end;

procedure AtualizaStatusBar(var postBar: TStatusBar; psVersao: String;
  pdDataOperacao,pdDataInicio: TDate; pdAtualizaDatas: Boolean = True);
var
  lsData,lsPrograma: String;
begin
  postBar.Font.Size := 8;
  postBar.Font.Color := clTeal;

  postBar.Panels[0].style := psText;
//  stBar.Panels[0].width := (length('USU�RIO: '+rInfoLogin.sNomeUsuario)+10)*5;
//  stBar.Panels[0].Text := 'USU�RIO: '+rInfoLogin.sNomeUsuario;
//  if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
  if TUtil.getUsaUserControl(rInfoAplicacao.iSerial) then begin
    postBar.Panels[0].width := (length('USU�RIO: '+rInfoLogin.sNomeUsuario)+10)*5;
    postBar.Panels[0].Text := 'USU�RIO: '+rInfoLogin.sNomeUsuario;
  end else begin
    postBar.Panels[0].width := (length('USU�RIO: master')+10)*5;
    postBar.Panels[0].Text := 'USU�RIO: master';
  end;

  postBar.Panels[1].style := psText;
  postBar.Panels[1].width := (length('Vers�o: '+psVersao)+10)*5;
  postBar.Panels[1].Text := 'Vers�o: '+psVersao;

  postBar.Panels[2].style := psText;
  postBar.Panels[2].width := 450;
//  postBar.Panels[2].Text := TUtil.getStrCodigoPessoa+'-'+Copy(TUtil.GetNomePessoa,1,70)+' '+TUtil.getTipoInscMfPessoa+': '+TUtil.getInscMfPessoa;

  if pdAtualizaDatas then begin
    lsPrograma := UpperCase(ExtractFileName(Application.ExeName));
    if (lsPrograma = 'MEGAPESSOAL.EXE') or (lsPrograma = 'MEGAFISCAL.EXE') then begin
      if pdDataOperacao <> TP_DATA_EMPTY then begin
        lsData := 'M�s/Ano: '+MesAno(pdDataOperacao,true);
      end else begin
        if (lsPrograma = 'MEGAFISCAL.EXE') and (pdDataInicio >= TP_DATA_INICIAL) then begin
          lsData := 'M�s/Ano: '+MesAno(pdDataInicio,true);
        end else begin
          lsData := '';
        end;
      end;
    end else if (lsPrograma = 'MEGACONTABIL.EXE') then begin
      lsData := 'Ano: '+StrZero(year(pdDataOperacao),4,0);
    end;
    postBar.Panels[3].style := psText;
    postBar.Panels[3].width := (length(lsData)+10)*5;
    postBar.Panels[3].Text  := lsData;

    if (pdDataInicio <> TP_DATA_EMPTY) then begin
      if (pdDataInicio >= TP_DATA_INICIAL) then begin
        lsData := 'Data de In�cio: '+DateToStr(pdDataInicio);
      end else begin
        lsData := 'Data de In�cio: '+DateToStr(BeginOfMonth(Date()));
      end;
    end;

    postBar.Panels[4].style := psText;
    postBar.Panels[4].width := (length(lsData)+10)*5;
    postBar.Panels[4].Text  := lsData;
  end;
end;

function BooleanToInt(pbBoolean: Boolean): Integer;
begin
  Result := pbBoolean.ToInteger;
end;

function IntToBoolean(piInteger: Integer): Boolean;
begin
  Result := piInteger.ToBoolean;
end;

function DecimalToRomano( piDecimal: LongInt ): String;
const
  Romans: Array[1..13] of String = ( 'I', 'IV', 'V', 'IX', 'X', 'XL', 'L',
  'XC', 'C', 'CD', 'D', 'CM', 'M' );
  Arabics: Array[1..13] of Integer =( 1, 4, 5, 9, 10, 40, 50, 90, 100,
  400, 500, 900, 1000);
var
  liFor: Integer;
  lsCratch: String;
begin
  lsCratch := '';
  for liFor := 13 downto 1 do begin
    while ( piDecimal >= Arabics[liFor] ) do begin
      piDecimal := piDecimal - Arabics[liFor];
      lsCratch := lsCratch + Romans[liFor];
    end;
  end;
  Result := lsCratch;
end;

function IncValue(var value: Integer; piIncremento: Integer = 1): Integer;
begin
  inc(value,piIncremento);
  Result := value;
end;

function IncLongWord(var value: LongWord): LongWord;
begin
  value := value+1;
  Result := value;
end;

function fEnderecoPessoa(poCdsPessoa: TClientDataSet; pTamanhoLinha: Integer): String;
  function ConcatenaEndereco(poCdsPessoa: TClientDataSet; pAbreviaLogradouro: Boolean): String;
  begin
    if Result <> '' then begin
      Result := Result+' ';
    end;
    if pAbreviaLogradouro then begin
      Result := Result+AbreviaNome(poCdsPessoa.FieldByName('LOGRADOURO').AsString);
    end else begin
      Result := Result+poCdsPessoa.FieldByName('LOGRADOURO').AsString;
    end;
    if poCdsPessoa.FieldByName('NUMERO').AsString <> '' then begin
      Result := Result+', '+poCdsPessoa.FieldByName('NUMERO').AsString;
    end;
    if poCdsPessoa.FieldByName('COMPLEMENTO').AsString <> '' then begin
      Result := Result+', '+poCdsPessoa.FieldByName('COMPLEMENTO').AsString;
    end;
    Result := Result+', '+poCdsPessoa.FieldByName('CIDADE').AsString+'-'+poCdsPessoa.FieldByName('ESTADO').AsString;
    Result := Result+', '+poCdsPessoa.FieldByName('CEP').AsString;
  end;
begin
  Result := '';
  {Concatena o endere�o sem abreviar}
  Result := ConcatenaEndereco(poCdsPessoa,false);
  if length(Result) > pTamanhoLinha then begin
    {Se o endere�o ficar maior que o tamanho da linha, concatena o endere�o
     abreviando os nomes do meio da descri��o do logradouro. Ex: Rua Andr�
     Luis Ribeiro da Fonte, retorna Rua Andr� L. R. da Fonte}
    Result := ConcatenaEndereco(poCdsPessoa,true);
  end;
end;

procedure OrdenaDataSetGrid(
  var CDS: TClientDataSet; Column: TColumn; var dbgPrin: TDBGrid);
const
  idxDefault = 'DEFAULT_ORDER';
var
  strColumn : string;
  i : integer;
  bolUsed : boolean;
  idOptions : TIndexOptions;
begin

  strColumn := idxDefault;

  if Column.Field.FieldKind in [fkCalculated, fkLookup, fkAggregate] then begin
    Exit;
  end;

  if Column.Field.DataType in [ftBlob, ftMemo] then begin
    Exit;
  end;

  for i := 0 to dbgPrin.Columns.Count -1 do begin
    dbgPrin.Columns[i].Title.Font.Style := [];
  end;

  bolUsed := (Column.Field.FieldName = CDS.IndexName);

  CDS.IndexDefs.Update;
  for i := 0 to CDS.IndexDefs.Count - 1 do begin
    if CDS.IndexDefs.Items[i].Name = Column.Field.FieldName then begin
      strColumn := Column.Field.FieldName;
      case (CDS.IndexDefs.Items[i].Options = [ixDescending]) of
        true : idOptions := [];
        false : idOptions := [ixDescending];
      end;
    end;
  end;

  if (strColumn = idxDefault)  or (bolUsed) then begin
    if bolUsed then begin
      CDS.DeleteIndex(Column.Field.FieldName);
    end;

    try
      CDS.AddIndex(Column.Field.FieldName, Column.Field.FieldName, idOptions, '', '', 0);
      strColumn := Column.Field.FieldName;
    except
      if bolUsed then begin
        strColumn := idxDefault;
      end;
    end;
  end;

  try
   CDS.IndexName := strColumn;
   Column.Title.Font.Style := [fsbold];
  except
   CDS.IndexName := idxDefault;
  end;
end;

function IsInternetConected(): Boolean;
const
  Key = '\System\CurrentControlSet\Services\RemoteAccess';
  Value = 'Remote Connection';
var
  Reg: TRegistry; {Unit Registry.pas}
  Buffer: DWord;
begin
  Result := false;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(Key, false) then
    begin
      Reg.ReadBinaryData(Value, Buffer, SizeOf(Buffer));
      Result := Buffer = 1;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;
end.


unit inkStack_node;
{<*** Stack NODE [ mangust © 29.01.2010 ]
    * Узел СТЕКА, который в свою очередь построен на СвязанномСписке
    *}
{//... Description ................................. mangust © 29.01.2010 ...///
///                         _____ _           _                              ///
///                        |   __| |_ ___ ___| |_                            ///
///                        |__   |  _| .'|  _| '_|                           ///
///                        |_____| |_|__,|___|_,_|                           ///
///                              |___|      v 4.0                            ///
///                                                                          ///
///--------------------------------------------[ v 4.0 in0k © 29.05.2013 ]---//}
interface
{%region /fold}//----------------------------------[ compiler directives ]
{}  {$ifdef fpc}                                             { это для LAZARUS }
{}     {$mode delphi}     // для пущей совместимости написанного кода         {}
{}     {$define _INLINE_}                                                     {}
{}  {$else}                                                   { это для DELPHI }
{}     {$IFDEF SUPPORTS_INLINE}                                               {}
{}       {$define _INLINE_}                                                   {}
{}     {$endif}                                                               {}
{}  {$endif}                                                                  {}
{}  {$ifOpt D+} // режим дебуга ВКЛЮЧЕН                      { "боевой" INLINE }
{}       {$undef _INLINE_} // дeбугить просче БЕЗ INLIN`а                     {}
{}  {$endif}                                                                  {}
{%endregion}//-------------------------------------------[ compiler directives ]
type

  {УЗЕЛ связного списка }
 rInkNodeStack=record
    next:pointer;  //< ссылка-указатель на следующий элемент очереди
    DATA:pointer;  //< ссылка-указатель на полезную информацию
  end;

  {УКАЗАТЕЛЬ на УЗЕЛ связного списка }
 pInkNodeStack=^rInkNodeStack;

type

  {"callBack" при УНИЧТОЖЕНИИ !!! СТАТИЧЕСКАЯ функция !!!
    @param(NODE указатель на УЗЕЛ списка [pInkNodeStack])  }
 fInkNodeStack_doDispose=procedure(NODE:pointer);
  {"callBack" при обходе очереди !!! метод ОБЪЕКТА-класса !!!
    @param(NODE указатель на УЗЕЛ очереди [pInkNodeStack]) }
 aInkNodeStack_doDispose=procedure(NODE:pointer) of object;

  {"callBack" обработать Узел при обходе очереди !!! СТАТИЧЕСКАЯ функция !!!
    @param (Data АДРЕС-памяти, некая инфа используемая при обходе)
    @param (NODE это ссылка-указатель на УЗЕЛ очереди [pQueueNode])
    @return(continue @true -- продолжить обход; @false -- ПРЕКРАТИТЬ)  }
 fInkNodeStack_doProcess=function(const Data:pointer; const NODE:pointer):boolean;
  {"callBack" обработать Узел при обходе очереди !!! метод ОБЪЕКТА-класса !!!
    @param (Data АДРЕС-памяти, некая инфа используемая при обходе)
    @param (NODE это ссылка-указатель на УЗЕЛ очереди [pQueueNode])
    @return(@true -- продолжить обход; @false -- ПРЕКРАТИТЬ)  }
 aInkNodeStack_doProcess=function(const Data:pointer; const NODE:pointer):boolean;

type

 tInkStackIndex=NativeUint;
 tInkStackCount=tInkStackIndex;

const
 cInkStack_MaxCount=high(tInkStackCount);
 cInkStack_NdfIndex=cInkStack_MaxCount;
 cInkStack_MaxIndex=cInkStack_NdfIndex-1;

procedure InkNodeStack_Create (out node:pointer; const DATA,NEXT:pointer);      {$ifdef _INLINE_} inline; {$endif} overload;
procedure InkNodeStack_Create (out node:pointer);                               {$ifdef _INLINE_} inline; {$endif} overload;
procedure InkNodeStack_Destroy(var node:pointer);                               {$ifdef _INLINE_} inline; {$endif}
//---
procedure InkNodeStack_setNext(const node,next:pointer);                        {$ifdef _INLINE_} inline; {$endif}
function  InkNodeStack_getNext(const node:pointer):pointer;                     {$ifdef _INLINE_} inline; {$endif}
//---
function  InkNodeStack_getDATA(const node:pointer):pointer;                     {$ifdef _INLINE_} inline; {$endif}

implementation

procedure InkNodeStack_Create(out node:pointer; const DATA,NEXT:pointer);
begin
    new(pInkNodeStack(node));
    pInkNodeStack(node)^.DATA:=DATA;
    pInkNodeStack(node)^.next:=NEXT;
end;

procedure InkNodeStack_Create(out node:pointer);
begin
    InkNodeStack_Create(node, nil,nil);
end;

procedure InkNodeStack_Destroy(var node:pointer);
begin
    DISPOSE(pInkNodeStack(node));
end;

//------------------------------------------------------------------------------

{[УЗЕЛ связного списка] установить следующим элементом}
procedure InkNodeStack_setNext(const node,next:pointer);
begin
    pInkNodeStack(Node)^.next:=next;
end;

{[УЗЕЛ связного списка] вернуть указатель на следующий}
function InkNodeStack_getNext(const node:pointer):pointer;
begin
    result:=pInkNodeStack(Node)^.next;
end;

{[УЗЕЛ связного списка] вернуть указатель на ДАННЫЕ}
function InkNodeStack_getDATA(const node:pointer):pointer;
begin
    result:=pInkNodeStack(Node)^.next;
end;

end.

{//---[ v 4.0 in0k © 29.05.2013 ]--------------------------------------------///
    если не смотреть ниначто, то это можно считать рождением данной библиотеки
///--------------------------------------------------------------------------//}




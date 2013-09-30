#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global counter
global input
global delayBetweenSend
global usingHQMats


Initialize()
{
   Gui, Add, Checkbox, vusingHQMats, Use HQ mats?
   Gui, Add, Text, section, Craft how many items?
   Gui, Add, Text,, Use what skill?
   Gui, Add, Text,, Length of delay between skill? (in milisecond)   
   Gui, Add, Edit, Number vcounter ys, 
   Gui, Add, Edit, vinput, 
   Gui, Add, Edit, Number vdelayBetweenSend,
   Gui, Add, Button, default, OK
   return
}

Initialize()
return

#Del::
MsgBox, 
(
Sending - "%input%" x %counter%
wait -- %delayBetweenSend% milisecond.
Use HQ Mats -- %usingHQMats%
)
return

#Enter::
GetInput()
return

RControl & `::
StartCrafting()
return

Pause::Pause

#q::
ExitApp
return

GetInput()
{
   global   
   Gui, Show,,Soak Tester   
   return
      
   ButtonOK:
   Gui, Submit
   return
}

StartCrafting()
{
   CreateProgressBar()
   craftingItemNumber := 0
   Loop       
   {
      craftingItemNumber++      
      Sleep, %delayBetweenSend%
      Send {Numpad0}
      if usingHQMats == true
      {
         SelectHQMats()
      }
      Sleep, %delayBetweenSend%
      Send {Numpad0}
      Loop 4
      {
         Sleep, %delayBetweenSend%
         Send {%input%}      
      }   
      UpdateProgressBar(craftingItemNumber, counter)
      if (craftingItemNumber >= counter)
      {
         break
      }
   }
   
   return
}

SelectHQMats()
{   
   Throw, TODO
   return
}

CreateProgressBar()
{
   global 
   Gui, ProgressBar:New
   Gui, ProgressBar:Add, Progress, w200 vprogressStatus   
   Gui, ProgressBar:Show, NA ,Crafting Progress
   return
}

UpdateProgressBar(currentValue, maxValue)
{
   if (maxValue > 0)
   {      
      position := ((currentValue/maxValue) * 100)
      GuiControl,,progressStatus, %position%
   }
   return
}

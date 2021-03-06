//+------------------------------------------------------------------+
//| Module: Experts/UIApp.mqh                                        |
//| This file is part of the mql4-lib-examples project:              |
//|     https://github.com/dingmaotu/mql4-lib-examples               |
//|                                                                  |
//| Copyright 2015-2017 Li Ding <dingmaotu@hotmail.com>              |
//|                                                                  |
//| Licensed under the Apache License, Version 2.0 (the "License");  |
//| you may not use this file except in compliance with the License. |
//| You may obtain a copy of the License at                          |
//|                                                                  |
//|     http://www.apache.org/licenses/LICENSE-2.0                   |
//|                                                                  |
//| Unless required by applicable law or agreed to in writing,       |
//| software distributed under the License is distributed on an      |
//| "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,     |
//| either express or implied.                                       |
//| See the License for the specific language governing permissions  |
//| and limitations under the License.                               |
//+------------------------------------------------------------------+
#property strict

#include <Mql/Lang/Mql.mqh>
#include <Mql/Lang/ExpertAdvisor.mqh>
#include <Mql/UI/FreeFormElement.mqh>
//+------------------------------------------------------------------+
//| UIApp parameters                                                 |
//+------------------------------------------------------------------+
class UIAppParam: AppParam
  {
   ObjectAttr(color,background,Background);
public:
   bool              check() {return true;}
  };
//+------------------------------------------------------------------+
//| UIApp: base class for pure UI applications                       |
//+------------------------------------------------------------------+
class UIApp: public ExpertAdvisor
  {
private:
   UIRoot            m_root;
   Panel            *m_panel;
   color             m_background;

public:
                     UIApp(UIAppParam*param);
                    ~UIApp() {m_root.restoreBackgroundElements();}

   void              refresh() {m_root.redraw();}
   virtual void      onChartChange();

   Panel            *getPanel() {return m_panel;}
  };
//+------------------------------------------------------------------+
//| Initialize an empty background                                   |
//+------------------------------------------------------------------+
UIApp::UIApp(UIAppParam*param)
   :m_background(param.getBackground())
  {
   m_root.hideBackgroundElements();
   m_panel=new Panel(GetPointer(m_root),"toplevel",0,0,m_root.getWidth(),m_root.getHeight());
   m_panel.setBackgroundColor(m_background);
   m_root.add(m_panel);
  }
//+------------------------------------------------------------------+
//| Handle top level window resize                                   |
//+------------------------------------------------------------------+
void UIApp::onChartChange()
  {
// possible resize
   m_panel.setSize(m_root.getWidth(),m_root.getHeight());
   m_root.redraw();
  }
//+------------------------------------------------------------------+

# coding: iso-8859-1
require 'tk'
require_relative './simplan.rb'

def proc_execute
    s = SimplanRetriver.new
    s.get_actions
end

root = TkRoot.new
img = TkPhotoImage.new('file'=>'ruby.png')
root.iconphoto(img)

root.title = "Ruby Gestão de Integração DW/Oracle|Redmine v1.0"
root.minsize(450,50)
#root.maxsize(450,80)

file_menu = TkMenu.new(root)

menu_click = Proc.new {
  Tk.messageBox(
    'type' => "ok",
    'icon' => "info",
    'title' => "Configurado",
    'message' => "Redmine"
  )
}

class OracleWin
  @instance = new
  private_class_method :new
  def self.instance
    @instance
  end
end

menu_oracle = Proc.new {
  oracle_win = TkToplevel.new(root)
  oracle_img = TkPhotoImage.new('file'=>'oracle-icon.png')
  oracle_win.iconphoto(oracle_img)

  lbl_ora_hr = TkLabel.new(oracle_win)
  lbl_ora_hr.text("User:")
  lbl_ora_hr.place('x'=>0,'y'=>0)
  
  hr_entry = TkEntry.new(oracle_win)
  hr_entry.place('height'=>30,'width'=>300,'x'=>100,'y'=>0)
  
  oracle_win.minsize(400,400)
  oracle_win.title = "Oracle Config"
}

sobre_click = Proc.new {
    Tk.messageBox(
    'type' => "ok",
    'icon' => "info",
    'title' => "Licença MIT",
    'message' => "The MIT License (MIT)

Copyright (c) 2020 David Borges Reis e Silva

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: 

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
  )
}

file_menu.add('command',
              'label' => "Redmine",
              'command' => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label' => "Oracle",
              'command' => menu_oracle,
              'underline' => 0)

sobre_menu = TkMenu.new(root)
sobre_menu.add('command',
               'label' =>"Licença",
               'command' => sobre_click,
               'underline'=>0)

menu_bar = TkMenu.new

menu_bar.add('cascade',
             'menu' => file_menu,
             'label' => "Arquivo"
            )
menu_bar.add('cascade',
             'menu' => sobre_menu,
             'label' => "Sobre"
            )

root.menu(menu_bar)


label = TkLabel.new(root)
label.image = img
label.place('height' => img.height,
            'width' => img.width,
            'x'=>10, 'y'=>10)

lbl1 = TkLabel.new(root)
lbl1.text("X-Redmine-API-Key")
lbl1.place('x'=>0, 'y'=>100)

e = TkEntry.new(root)
e.background 'white'
e.place('height'=>20, 'width'=>250,
'x'=>0, 'y'=>110)

btn = TkButton.new(root) do
 text "Executar"
 command(proc {proc_execute})
 place('x'=>0,'y'=>120)
end

btn_exit = TkButton.new(root)
btn_exit.text "Sair"
btn_exit.command(proc {exit})
btn_exit.place('x'=>130,'y'=>120)

btn_ora = TkButton.new(root)
btn_ora.text "Gravar Oracle"
btn_ora.command(proc {ora_record})
btn_ora.place('x'=>260,'y'=>120)

Tk.mainloop

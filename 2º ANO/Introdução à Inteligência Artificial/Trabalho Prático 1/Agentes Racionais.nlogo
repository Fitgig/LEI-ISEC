; DEFINIÇÃO DE VARIÁVEIS
breed[basics basic]
breed[experts expert]
breed[robins robin]

globals[abrigos]

turtles-own[experience energia-experts energia-basics energia-robins]
experts-own[counter alimento-amarelo alimento-verde]

; CONFIGURAÇÃO DO AMBIENTE
; SETUP
to setup
  clear-all

  setup-patches
  setup-turtles

  if modelo-melhorado1[
    setup-patches-melhorado
    setup-turtles-melhorado
  ]

  reset-ticks
end

; GO
to go
  move-basics
  move-experts

  morte-turtles

  if modelo-melhorado1[
    modelo-melhorado
  ]

  tick

  if count turtles = 0 or ticks = 1000[
    stop
  ]

  mostra-labels
end

; SETUP DAS PATCHES
to setup-patches
  clear-all
  set-patch-size 15

  ; COR DOS PATCHES (0%-15% VERDES, 0%-5% AMARELAS, 0-2% VERMELHAS, 1-10 AZUIS)
  ask patches
  [
    if random 101 < celulas_verdes
    [
      set pcolor green
    ]
    if random 101 < celulas_amarelas
    [
      set pcolor yellow
    ]
    if random 101 < armadilhas
    [
      set pcolor red
    ]
  ]
  ask n-of nabrigos patches [set pcolor blue]
  ;ask patches with [pcolor = black][set pcolor white]
end

; SETUP DAS TURTLES
to setup-turtles
  clear-turtles

  ; CRIAR AGENTES (OS BASICS)
  create-basics nbasics
  [
    set shape "bug"
    set color 125
    set size 1.5
    setxy random-xcor random-ycor

    while[[pcolor] of patch-here = red]
    [
      setxy random-xcor random-ycor
    ]
  ]

  ; CRIAR AGENTES (OS EXPERTS)
  create-experts nexperts
  [
    set shape "butterfly"
    set color 135
    set size 1.5
    setxy random-xcor random-ycor

    while[[pcolor] of patch-here = red]
    [
      setxy random-xcor random-ycor
    ]
  ]

  ; INICIALIZAR VARIÁVEIS DOS BASICS
  ask basics
  [
    set energia-basics 100
  ]

  ; INICIALIZAR VARIÁVEIS DOS EXPERTS
  ask experts
  [
    set energia-experts 100
    set experience 0
    set alimento-verde 0
    set alimento-amarelo 0
  ]

  mostra-labels
end

; MORTE DAS TURTLES
to morte-turtles
  ; MORTE DOS AGENTES BASICS (SE ENERGIA <= 0)
  ask basics
  [
    if energia-basics <= 0
    [
      die
    ]
  ]
  ; MORTE DOS AGENTES EXPERTS (SE ENERGIA <= 0)
  ask experts
  [
    if energia-experts <= 0
    [
      die
    ]
  ]
end

; MOVIMENTO DOS AGENTES "BASICS"
to move-basics
  ask basics
  [
    ; PERDE 1 DE ENERGIA EM CADA MOVIMENTO
    set energia-basics energia-basics - 1

    ; PERCECIONAR CÉLULA AMARELA À FRENTE (COMIDA)
    if [pcolor] of patch-ahead 1 = yellow
    [
      forward 1
      set energia-basics energia-basics + 10
      set pcolor black
      ask one-of patches with [pcolor = black]
      [
        set pcolor yellow
      ]
    ]

    ; PERCECIONAR CÉLULA AMARELA À DIREITA (COMIDA)
    if [pcolor] of patch-right-and-ahead 90 1 = yellow
    [
      right 90
      forward 1
      set energia-basics energia-basics + 10
      set pcolor black
      ask one-of patches with [pcolor = black]
      [
        set pcolor yellow
      ]
    ]

    ; PERCECIONAR CÉLULA AZUL À FRENTE (ABRIGO)
    if [pcolor] of patch-ahead 1 = blue
    [
      ; AGENTES EXPERTS NO ABRIGO
      if any? experts-on patch-ahead 1
      [
        set energia-basics energia-basics - (energia-basics * 0.05)
      ]
      ; SEM AGENTES EXPERTS NO ABRIGO
      if not any? experts-on patch-ahead 1
      [
        right 90
        forward 1
      ]
    ]

    ; PERCECIONAR CÉLULA AZUL À DIREITA (ABRIGO)
    if [pcolor] of patch-right-and-ahead 90 1 = blue
    [
      ; AGENTES EXPERTS NO ABRIGO
      if any? experts-on patch-right-and-ahead 90 1
      [
        set energia-basics energia-basics - (energia-basics * 0.05)
      ]
      ; SEM AGENTES EXPERTS NO ABRIGO
      if not any? experts-on patch-right-and-ahead 90 1
      [
        forward 1
      ]
    ]

    ; PERCECIONAR CÉLULA VERMELHA À FRENTE (ARMADILHA)
    if [pcolor] of patch-ahead 1 = red
    [
      if energia-basics < 100
      [
        die
      ]
      if energia-basics >= 100
      [
        set energia-basics energia-basics - (0.1 * energia-basics)
      ]
      right 90
      forward 1
    ]

    ; PERCECIONAR CÉLULA VERMELHA À DIREITA (ARMADILHA)
    if [pcolor] of patch-right-and-ahead 90 1 = red
    [
      if energia-basics < 100
      [
        die
      ]
      if energia-basics >= 100
      [
        set energia-basics energia-basics - (0.1 * energia-basics)
      ]
      forward 1
    ]

    ; PERCECIONAR AGENTES EXPERTS FORA DO ABRIGO (FRENTE)
    if any? experts-on patch-ahead 1 and [pcolor] of patch-ahead 1 != blue and experience < 50
    [
      ask one-of experts-on patch-ahead 1
      [
        set energia-basics energia-basics + (0.5 * energia-experts)
      ]
    ]

    ; PERCECIONAR AGENTES EXPERTS FORA DO ABRIGO (FRENTE)
    if any? experts-on patch-ahead 1 and [pcolor] of patch-ahead 1 != blue and experience >= 50
    [
      ask one-of experts-on patch-ahead 1
      [
        set energia-basics energia-basics - (0.1 * energia-basics)
      ]
    ]

    ; PERCECIONAR AGENTES EXPERTS FORA DO ABRIGO (DIREITA)
    if any? experts-on patch-right-and-ahead 90 1 and [pcolor] of patch-right-and-ahead 90 1 != blue and experience < 50
    [
      ask one-of experts-on patch-right-and-ahead 90 1
      [
        set energia-basics energia-basics + (0.5 * energia-experts)
      ]
    ]

    ; PERCECIONAR AGENTES EXPERTS FORA DO ABRIGO (DIREITA)
    if any? experts-on patch-right-and-ahead 90 1 and [pcolor] of patch-right-and-ahead 90 1 != blue and experience >= 50
    [
      ask one-of experts-on patch-right-and-ahead 90 1
      [
        set energia-basics energia-basics - (0.1 * energia-basics)
      ]
    ]
    forward 1
  ]
end

; MOVIMENTO DOS AGENTES "EXPERTS"
to move-experts
  ask experts
  [
    ; PERDE 1 DE ENERGIA EM CADA MOVIMENTO
    set energia-experts energia-experts - 1

    ; PERCECIONAR CÉLULA AMARELA À FRENTE (COMIDA)
    if [pcolor] of patch-ahead 1 = yellow
    [
      forward 1
      set energia-experts energia-experts + 5
      set pcolor black
      set alimento-amarelo alimento-amarelo + 1
      ask one-of patches with [pcolor = black]
      [
        set pcolor yellow
      ]

      ; A CADA 10 ALIMENTOS
      if alimento-amarelo = 10
      [
        set experience experience + 1
        set alimento-amarelo 0
      ]
    ]

    ; PERCECIONAR CÉLULA VERDE À FRENTE (COMIDA)
    if [pcolor] of patch-ahead 1 = green
    [
      forward 1
      set energia-experts energia-experts + 10
      set pcolor black
      set alimento-verde alimento-verde + 1
      ask one-of patches with [pcolor = black]
      [
        set pcolor green
      ]

      ; A CADA 10 ALIMENTOS
      if alimento-verde = 10
      [
        set experience experience + 2
        set alimento-verde 0
      ]
    ]

    ; PERCECIONAR CÉLULA AMARELA À DIREITA (COMIDA)
    if [pcolor] of patch-right-and-ahead 90 1 = yellow
    [
      right 90
      forward 1
      set energia-experts energia-experts + 5
      set pcolor black
      set alimento-amarelo alimento-amarelo + 1
      ask one-of patches with [pcolor = black]
      [
        set pcolor yellow
      ]

      ; A CADA 10 ALIMENTOS
      if alimento-amarelo = 10
      [
        set experience experience + 1
        set alimento-amarelo 0
      ]
    ]

    ; PERCECIONAR CÉLULA VERDE À DIREITA (COMIDA)
    if [pcolor] of patch-right-and-ahead 90 1 = green
    [
      right 90
      forward 1
      set energia-experts energia-experts + 10
      set pcolor black
      set alimento-verde alimento-verde + 1
      ask one-of patches with [pcolor = black]
      [
        set pcolor green
      ]

      ; A CADA 10 ALIMENTOS
      if alimento-verde = 10
      [
        set experience experience + 2
        set alimento-verde 0
      ]
    ]

    ; PERCECIONAR CÉLULA AMARELA À ESQUERDA (COMIDA)
    if [pcolor] of patch-left-and-ahead 90 1 = yellow
    [
      left 90
      forward 1
      set energia-experts energia-experts + 5
      set pcolor black
      set alimento-amarelo alimento-amarelo + 1
      ask one-of patches with [pcolor = black]
      [
        set pcolor yellow
      ]

      ; A CADA 10 ALIMENTOS
      if alimento-amarelo = 10
      [
        set experience experience + 1
        set alimento-amarelo 0
      ]
    ]

    ; PERCECIONAR CÉLULA VERDE À ESQUERDA (COMIDA)
    if [pcolor] of patch-left-and-ahead 90 1 = green
    [
      left 90
      forward 1
      set energia-experts energia-experts + 10
      set pcolor black
      set alimento-verde alimento-verde + 1
      ask one-of patches with [pcolor = black]
      [
        set pcolor green
      ]

      ; A CADA 10 ALIMENTOS
      if alimento-verde = 10
      [
        set experience experience + 2
        set alimento-verde 0
      ]
    ]

    ; PERCECIONAR CÉLULA AZUL À FRENTE (ABRIGO)
    if [pcolor] of patch-ahead 1 = blue
    [
      if not any? turtles-on patch-ahead 1 and (energia-experts < 500 or experience < 25)
      [
        ; PERMANECER 10 TICKS?
        ifelse counter = 0
        [
          forward 1
          set counter 10
        ]
        [
          set counter counter - 1
        ]
        ;set energia-experts energia-experts + 500
        set experience experience + 25
        forward 1
      ]
      ; COMO AFASTAR DO ABRIGO?
      right 90
      forward 1
    ]

    ; PERCECIONAR CÉLULA AZUL À DIREITA (ABRIGO)
    if [pcolor] of patch-right-and-ahead 90 1 = blue
    [
      if not any? turtles-on patch-right-and-ahead 90 1 and (energia-experts < 500 or experience < 25)
      [
        ; ESPERAR 10 TICKS?
        ifelse counter = 0
        [
          forward 1
          set counter 10
        ]
        [
          set counter counter - 1
        ]
        set energia-experts energia-experts + 500
        set experience experience + 25
        forward 1
      ]
      ; COMO AFASTAR DO ABRIGO?
      forward 1
    ]

    ; PERCECIONAR CÉLULA AZUL À ESQUERDA (ABRIGO)
    if [pcolor] of patch-left-and-ahead 90 1 = blue
    [
      if not any? turtles-on patch-left-and-ahead 90 1 and (energia-experts < 500 or experience < 25)
      [
        ; ESPERAR 10 TICKS?
        ifelse counter = 0
        [
          forward 1
          set counter 10
        ]
        [
          set counter counter - 1
        ]
        set energia-experts energia-experts + 500
        set experience experience + 25
        forward 1
      ]
      ; COMO AFASTAR DO ABRIGO?
      forward 1
    ]

    ; PERCECIONAR CÉLULA VERMELHA À FRENTE (ARMADILHAS)
    if [pcolor] of patch-ahead 1 = red
    [
      if experience < 50 and energia-experts >= 100
      [
        set energia-experts energia-experts - (energia-experts * 0.1)
      ]
      if experience < 50 and energia-experts < 100
      [
        die
      ]
    ]

    ; PERCECIONAR CÉLULA VERMELHA À DIREITA (ARMADILHAS)
    if [pcolor] of patch-right-and-ahead 90 1 = red
    [
      if experience < 50 and energia-experts >= 100
      [
        set energia-experts energia-experts - (energia-experts * 0.1)
      ]
      if experience < 50 and energia-experts < 100
      [
        die
      ]
    ]

    ; PERCECIONAR CÉLULA VERMELHA À ESQUERDA (ARMADILHAS)
    if [pcolor] of patch-left-and-ahead 90 1 = red
    [
      if experience < 50 and energia-experts >= 100
      [
        set energia-experts energia-experts - (energia-experts * 0.1)
      ]
      if experience < 50 and energia-experts < 100
      [
        die
      ]
    ]

    ; PERCECIONAR UM AGENTE BASIC À FRENTE
    if any? basics-on patch-ahead 1
    [
      set energia-experts energia-experts + energia-basics
      ask one-of basics
      [
        die
      ]
    ]

    ; PERCECIONAR UM AGENTE BASIC À DIREITA
    if any? basics-on patch-right-and-ahead 90 1
    [
      set energia-experts energia-experts + energia-basics
      ask one-of basics
      [
        die
      ]
    ]

    ; PERCECIONAR UM AGENTE BASIC À ESQUERDA
    if any? basics-on patch-left-and-ahead 90 1
    [
      set energia-experts energia-experts + energia-basics
      ask one-of basics
      [
        die
      ]
    ]
    forward 1
  ]
end

; MOSTRA % DE ENERGIA EM CIMA DOS AGENTES
to mostra-labels
  ; ENERGIA DOS EXPERTS
  ask experts
  [
    if mostra-energia
    [
      set label energia-experts
    ]
  ]
  ; ENERGIA DOS BASICS
  ask basics
  [
    if mostra-energia
    [
      set label energia-basics
    ]
  ]
end

; MODELO MELHORADO
to modelo-melhorado
  ; MELHORIAS DOS BASICS
  ask basics
  [
    ; REPRODUÇÃO DOS AGENTES BASICS (FRENTE)
    if any? basics-on patch-ahead 1
    [
      forward 1
      set energia-basics energia-basics / 2.5
      hatch nfilhos [jump 3]
    ]
    ; REPRODUÇÃO DOS AGENTES BASICS (DIREITA)
    if any? basics-on patch-right-and-ahead 90 1
    [
      right 90
      forward 1
      set energia-basics energia-basics / 2.5
      ;hatch nfilhos [jump 6]
    ]
    ; COMER ALIMENTO VERDE (FRENTE)
    if [pcolor] of patch-ahead 1 = green
    [
      forward 1
      set energia-basics energia-basics + 5
    ]
    ; COMER ALIMENTO VERDE (DIREITA)
    if [pcolor] of patch-right-and-ahead 90 1 = green
    [
      right 90
      forward 1
      set energia-basics energia-basics + 5
    ]
  ]

  ask robins
  [
    ; RETIRA ENERGIA AOS AGENTES EXPERTS
    if any? experts-on neighbors
    [
      ask experts
      [
        set energia-experts energia-experts - (0.5 * energia-experts)
        if experience > 3 or energia-robins > 200
        [
          ask robins
          [
            set energia-robins energia-robins + (0.5 * energia-experts) ; FUNCIONA?
          ]
        ]
      ]
    ]
    ; DÁ ENERGIA AOS AGENTES BASICS
    if any? basics-on neighbors
    [
      ask basics
      [
        set energia-basics energia-basics + (0.3 * energia-robins)
      ]
    ]
    if [pcolor] of patch-ahead 1 != black[
      rt 90
      fd 1
    ]
    if [pcolor] of patch-right-and-ahead 90 1 != black[
      fd 1
    ]
    if [pcolor] of patch-left-and-ahead 90 1 != black[
      fd 1
    ]
    fd 1
  ]

  ask experts
  [
    if [pcolor] of patch-ahead 1 = brown
    [
      set energia-experts energia-experts - (0.3 * energia-experts)
    ]
    if [pcolor] of patch-right-and-ahead 90 1 = brown
    [
      set energia-experts energia-experts - (0.3 * energia-experts)
    ]
    if [pcolor] of patch-left-and-ahead 90 1 = brown
    [
      set energia-experts energia-experts - (0.3 * energia-experts)
    ]
  ]

end

; SETUP PATCHES DO MODELO MELHORADO
to setup-patches-melhorado
  ; VENENO
  ask patches
  [
    if random 101 < veneno
    [
      set pcolor 34
      set plabel "X"
      set plabel-color white
    ]
  ]
end

; SETUP TURTLES DO MODELO MELHORADO
to setup-turtles-melhorado
  ; CRIAÇÃO DOS ROBINS
    create-robins nrobins
    [
      set shape "person"
      set color white
      setxy random-xcor random-ycor
      set energia-robins 100
    ]
end
@#$#@#$#@
GRAPHICS-WINDOW
379
11
882
515
-1
-1
15.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
22
22
89
55
SETUP
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
23
112
131
145
celulas_verdes
celulas_verdes
0
15
15.0
1
1
NIL
HORIZONTAL

SLIDER
146
112
261
145
celulas_amarelas
celulas_amarelas
0
5
5.0
1
1
NIL
HORIZONTAL

SLIDER
24
156
116
189
armadilhas
armadilhas
0
2
2.0
1
1
NIL
HORIZONTAL

SLIDER
24
205
116
238
nbasics
nbasics
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
130
205
222
238
nexperts
nexperts
0
100
100.0
1
1
NIL
HORIZONTAL

BUTTON
110
23
173
56
GO
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
128
156
220
189
nabrigos
nabrigos
1
10
10.0
1
1
NIL
HORIZONTAL

SWITCH
240
181
366
214
mostra-energia
mostra-energia
0
1
-1000

MONITOR
23
255
118
300
Número de Basics
count basics
17
1
11

MONITOR
131
255
236
300
Número de Experts
count experts
17
1
11

MONITOR
248
255
342
300
Basics + Experts
count basics + count experts
17
1
11

SLIDER
24
540
116
573
nfilhos
nfilhos
0
2
1.0
1
1
NIL
HORIZONTAL

SWITCH
23
491
168
524
modelo-melhorado1
modelo-melhorado1
0
1
-1000

TEXTBOX
24
72
174
91
MODELO BASE:\n
15
0.0
0

TEXTBOX
25
448
226
486
MODELO MELHORADO:\n
15
0.0
0

TEXTBOX
21
85
355
103
___________________________________________________\n
11
0.0
1

TEXTBOX
22
461
408
479
____________________________________________________\n\n
11
0.0
1

SLIDER
125
540
217
573
veneno
veneno
0
5
5.0
1
1
NIL
HORIZONTAL

SLIDER
227
540
319
573
nrobins
nrobins
0
10
10.0
1
1
NIL
HORIZONTAL

PLOT
23
313
183
433
GRÁFICO
NIL
NIL
0.0
1000.0
0.0
100.0
true
false
"" ""
PENS
"default" 1.0 0 -5825686 true "" "plot count basics"
"pen-1" 1.0 0 -2064490 true "" "plot count experts"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="10" repetitions="10" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>ticks</metric>
    <metric>count basics</metric>
    <metric>count experts</metric>
    <enumeratedValueSet variable="nabrigos">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="celulas_verdes">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="modelo-melhorado1">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="armadilhas">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nbasics">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="veneno">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="celulas_amarelas">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nexperts">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nrobins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mostra-energia">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nfilhos">
      <value value="2"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@

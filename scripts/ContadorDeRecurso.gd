# Desenvolvido por João Ricardo Bittencourt
# Todo este código é considerado como uma biblioteca a distribuído sob a licença LGPL v3
tool
extends HBoxContainer

#Nome do recurso
export(String) var nome = "Default"
#O tick de relógio 
export(int) var tempo = 1
#Quantidade de recursos para incrementar
export(int) var quantidade = 1
#Se o temporizador inicia automático
export(bool) var auto_iniciar = false
#Qual ícone será usado na HUD
export(Texture) var icone setget _set_icone
#Qual o tema
export(Theme) var tema setget _set_tema

#Sinal é emitido toda vez que o recurso é produzido
signal recurso_incrementado(n,t)	

#Total de recurso
var total = 0

#Define o icone
func _set_icone(t):
	icone = t
	if (Engine.is_editor_hint()):
		$icone.texture = icone
	
#Define o tema
func _set_tema(t):
	tema = t
	if (Engine.is_editor_hint()):
		$icone.theme = tema
		$rotulo.theme = tema
	
#Retorna o total de recursos
func _get_total():
	return total
	
#Inicia o temporizador
func _comecar():
	$tempo.start()
	
#Para o temporizador
func _parar():
	$tempo.stop()
	
func _ready():
	$icone.texture = icone
	$icone.theme = tema
	$rotulo.theme = tema
	
	$tempo.wait_time = tempo
	$rotulo.text = "0"
	if auto_iniciar:
		_comecar()

func _on_tempo_timeout():
	total = total + quantidade
	$rotulo.text = str(total)
	emit_signal("recurso_incrementado",nome,total)
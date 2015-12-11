<?php
class frm_expediente extends burgos_v2_ei_formulario
{
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__denuncia_policial__procesar = function(es_inicial)
		{
			//me fijo si hubo denuncia policial. SOLO si la hubo muestro los ef de denuncia 
				if (this.ef('denuncia_policial').chequeado()) {
					this.ef('lugar_denuncia').mostrar(true);
					this.ef('fecha_denuncia').mostrar(true);
					this.ef('persona_denuncia').mostrar(true);
					this.ef('lugar_hecho_denuncia').mostrar(true);
					this.ef('ultimo_episodio_denuncia').mostrar(true);                    
				} else {
					this.ef('lugar_denuncia').mostrar(false);
					this.ef('fecha_denuncia').mostrar(false);
					this.ef('persona_denuncia').mostrar(false);
					this.ef('lugar_hecho_denuncia').mostrar(false);                    
					this.ef('ultimo_episodio_denuncia').mostrar(false);                    
		
					// this.ef('lugar_denuncia').resetear_estado();
					// this.ef('fecha_denuncia').set_estado('');
					// this.ef('persona_denuncia').set_estado('');
					// this.ef('lugar_hecho_denuncia').set_estado('');    
					
				}
		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__hubo_violencia__procesar = function(es_inicial)
		{
				if (this.ef('hubo_violencia').chequeado()) {
					this.ef('violencia_1').mostrar(true);
					this.ef('violencia_2').mostrar(true);
					this.ef('violencia_3').mostrar(true);
				} else {
					this.ef('violencia_1').mostrar(false);
					this.ef('violencia_2').mostrar(false);
					this.ef('violencia_3').mostrar(false);
					this.ef('violencia_1').resetear_estado();
					this.ef('violencia_2').resetear_estado();
					this.ef('violencia_3').resetear_estado();
					
				}
			
		}//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__id_ambito__procesar = function(es_inicial)
		{
		}
		";
	}

}
?>
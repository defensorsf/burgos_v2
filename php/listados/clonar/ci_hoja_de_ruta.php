<?php
class ci_hoja_de_ruta extends burgos_v2_ci
{
	protected $s__datos_filtro;

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
        if (isset($this->s__datos_filtro)){
			$where = $this->dep('filtro')->get_sql_where();
			$datos = toba::consulta_php('consultas')->get_hoja_de_ruta($where);
			$cuadro->set_datos($datos);
		}
	}

	function evt__cuadro__ordenar($columna, $sentido)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(burgos_v2_ei_filtro $filtro)
	{
		if (isset($this->s__datos_filtro)) {
			//ei_arbol($this->s__datos_filtro);
			//busco el expediente para saber sus datos. Me va a devolver un arreglo de arreglos con cada uno de los intervenientes en el expediente.
			$expedientes = $this->dep('datos')->tabla('expedientes')->get_personas_expedientes($this->s__datos_filtro);
			$rol='';
			$personas = '';
			$nomeclador = '';
			$titulo = '<table style="width: 100%;background-color: #FFFFFF;color: #000000;"><tr><td style = "font:caption">PERSONAS INVOLUCRADAS</td><td style = "font:caption">NOMECLADOR</td></tr>';
			foreach ($expedientes AS $expediente){
				//si o si esto sucede sólo en la primera interaccion
				//pongo la primera linea el rol y por unica vez el nomeclador
				if($rol == '' ){
					$rol = $expediente['rol'];
					$titulo .= "<tr><td style='color = red'>$rol</td><td>{$expediente['nomeclador']}</td></tr>";
					$titulo .= "<tr><td>&nbsp;&nbsp&nbsp;&nbsp;{$expediente['nombre_persona']}</td><td></td></tr>";
				}else{
					//es la segunda iteracción para adelante
					//Viene ordenado por rol. Por cada rol distinto lo pongo en el titulo y agrego las personas en ese rol.
					if ($rol <> $expediente['rol']){
						$rol = $expediente['rol'];
						$titulo .= "<tr><td>$rol</td><td></td></tr>";
						$titulo .= "<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;{$expediente['nombre_persona']}</td><td></td></tr>";
					} else {
						//solamente agrego personas a la tabla
						$titulo .= "<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;{$expediente['nombre_persona']}</td><td></td></tr>";
					}
				}
			}		
			$titulo .= "</table>";

			//ei_arbol($expedientes);
			$this->dep('cuadro')->set_titulo($titulo);
			$filtro->set_datos($this->s__datos_filtro);
		}   

	}

	function evt__filtro__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__datos_filtro);
	}

}
?>
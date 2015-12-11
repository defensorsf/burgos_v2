<?php
class ci_hoja_de_ruta extends burgos_v2_ci
{
	protected $s__datos_filtro;
	protected $id_busqueda;
	
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{		
			//$cuadro->set_titulo(toba::memoria()->get_dato('titulo'));
			$where = 'ex.id = ' . toba::memoria()->get_dato('id_busqueda');//$this->dep('filtro')->get_sql_where();
			$datos = toba::consulta_php('consultas')->get_hoja_de_ruta($where);
			$cuadro->set_datos($datos);
	}

	function evt__cuadro__ordenar($columna, $sentido)
	{
	}
	//-----------------------------------------------------------------------------------
	//---- cuadro_personas --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_personas(burgos_v2_ei_cuadro $cuadro)
	{
		if (isset($this->s__datos_filtro)){
			$cuadro->set_datos($this->dep('datos')->tabla('expedientes')->get_select_expedientes($this->s__datos_filtro));
		}else{
			$cuadro->set_datos($this->dep('datos')->tabla('expedientes')->get_select_expedientes());
		}

	}

	function evt__cuadro_personas__seleccion($seleccion)
	{
		$personas = $this->dep('datos')->tabla('expedientes')->get_personas_expedientes($seleccion);
		toba::memoria()->set_dato('hoja_ruta',$personas);
		$rol='';
		$cantidad_roles = 0;  //se usa para calcular la cantidad de lineas que utiliza el encabezado.
		$nomeclador = '';
		$titulo  = '<table style="width: 100%;background-color: Gainsboro;color: #000000;"><tr style="background-color: DarkSeaGreen"><td style = "font:caption">PERSONAS INVOLUCRADAS</td><td style = "font:caption">TEMA</td><td style = "font:caption">VIOLENCIA</td></tr>';
		foreach ($personas  AS $persona){
			//si o si esto sucede sólo en la primera interaccion
			//pongo la primera linea el rol y por unica vez el nomeclador
			if($rol == '' ){
				$rol = $persona['rol'];
				$titulo .= "<tr><td>$rol</td><td>{$persona['nomeclador']}</td><td>{$persona['violencia']}</td></tr>";
				$titulo .= "<tr><td>&nbsp;&nbsp&nbsp;&nbsp;{$persona['nombre_persona']}";
				$cantidad_roles += 1;
			}else{
				//es la segunda iteracción para adelante
				//Viene ordenado por rol. Por cada rol distinto lo pongo en el titulo y agrego las personas en ese rol.
				if ($rol <> $persona['rol']){
					$rol = $persona['rol'];
					$titulo .= "</td><td></td><td></td></tr><tr><td>$rol</td><td></td><td></td></tr>";
					$titulo .= "<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;{$persona['nombre_persona']}";
					$cantidad_roles += 1;
				} else {
					//solamente agrego personas a la tabla
					$titulo .= ", {$persona['nombre_persona']}";
				}
			}
		}		
		$titulo .= "</td><td></td><td></td></tr></table>";

		//pongo el titulo en el cuadro
		$this->dep('cuadro')->set_titulo($titulo);
		//Guardo en memoria el id del expediente seleccionado y el titulo.
		toba::memoria()->set_dato('id_busqueda' , $seleccion['id']);
		toba::memoria()->set_dato('cantidad_roles',$cantidad_roles);
		
		
		
		//paso al la pantalla
		$this->set_pantalla('pant_inicial');
	}

	//-----------------------------------------------------------------------------------
	//---- filtro_complejo --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro_complejo(burgos_v2_ei_filtro $filtro)
	{		
		if (isset($this->s__datos_filtro)) {
			$filtro->set_datos($this->s__datos_filtro);
		}   
	}

	function evt__filtro_complejo__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__filtro_complejo__cancelar()
	{
		unset($this->s__datos_filtro);
	}

}
?>
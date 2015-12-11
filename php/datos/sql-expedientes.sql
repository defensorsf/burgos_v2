SELECT DISTINCT
	ex.id,
	ex.numero,
	ex.fecha_presentacion,
	ex.lugar,
	'responsable' AS nombre_responsable_ingreso,
	ex.procedencia
FROM expedientes AS ex
INNER JOIN grupos_trabajos AS gt
ON ex.id = gt.id_personal
WHERE gt.primera_entrevista
AND gt.id IN
(SELECT id

)

ORDER BY 
	ex.numero
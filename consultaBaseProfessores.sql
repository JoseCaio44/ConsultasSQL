select * from docente
select * from lattes_p_prodbib
select * from lattes_prodbib
select * from qualis_conf
select * from qualis_rev
select * from suap_proj
select * from suap_p_proj

select p.nome, d.nome_completo 
	from docente as d 
		inner join suap_p_proj as s on d.siape = s.id_docente
		inner join suap_proj as p on s.id_proj = p.id
	order by d.nome_completo
		
SELECT docente.nome_completo, COUNT(*) AS proj
	FROM docente
		INNER JOIN (
 			SELECT suap_p_proj.id_docente, suap_p_proj.id_proj
  			FROM suap_p_proj
  			INNER JOIN suap_proj ON suap_p_proj.id_proj = suap_proj.id
  			WHERE suap_proj.area_conhecimento = 'CIÊNCIA DA COMPUTAÇÃO'
		) AS projetos_cc ON docente.siape = projetos_cc.id_docente
	INNER JOIN suap_p_proj ON docente.siape = suap_p_proj.id_docente
	GROUP BY docente.nome_completo ORDER BY proj;
	
SELECT docente.nome_completo, COUNT(*) AS artigos
	FROM docente
		INNER JOIN (
  			SELECT lattes_p_prodbib.id_docente, lattes_prodbib.id
  			FROM lattes_p_prodbib
  			INNER JOIN lattes_prodbib ON lattes_p_prodbib.id_prodbib = lattes_prodbib.id
 			INNER JOIN qualis_rev ON lattes_p_prodbib.id_prodbib = qualis_rev.id
 			WHERE qualis_rev.qualis = 'A1'
		) 
	AS artigos_a1 ON docente.siape = artigos_a1.id_docente
	GROUP BY docente.siape, docente.nome_completo
	ORDER BY artigos DESC;

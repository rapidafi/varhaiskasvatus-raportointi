create or replace view varda_rap_toimipaikka as
select
varda_toimipaikka.organisaatio_oid as toimipaikka_oid
,varda_toimipaikka.nimi
,varda_toimipaikka.nimi_sv
,varda_toimipaikka.varhaiskasvatuspaikat
,varda_toimipaikka.jarjestamismuoto_koodi
,varda_toimipaikka.kasvatusopillinen_jarjestelma_koodi
,varda_toimipaikka.kayntiosoite as toimipaikka_kayntiosoite
,varda_toimipaikka.kayntiosoite_postinumero as toimipaikka_kayntiosoite_postinumero
,varda_toimipaikka.kayntiosoite_postitoimipaikka as toimipaikka_kayntiosoite_postitoimipaikka
,varda_toimipaikka.toimintamuoto_koodi
,varda_toimipaikka.toiminnallinenpainotus_kytkin
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp01'),0)::boolean as tp01_musiikki
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp02'),0)::boolean as tp02_liikunta
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp03'),0)::boolean as tp03_kuvataide
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp04'),0)::boolean as tp04_tiede
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp05'),0)::boolean as tp05_draama
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp06'),0)::boolean as tp06_ymparisto_ja_luonto
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp07'),0)::boolean as tp07_seikkailu
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp08'),0)::boolean as tp08_media
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp09'),0)::boolean as tp09_maailmankatsomuksellinen
,coalesce((select 1 from varda_toiminnallinenpainotus where toimipaikka_id = varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and lower(toimintapainotus_koodi)='tp99'),0)::boolean as tp99_muu
,varda_toimipaikka.kielipainotus_kytkin
,coalesce((select 1 from varda_kielipainotus where toimipaikka_id=varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and upper(kielipainotus_koodi)='FI'),0)::boolean as "kielipainotus_fi"
,coalesce((select 1 from varda_kielipainotus where toimipaikka_id=varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and upper(kielipainotus_koodi)='SV'),0)::boolean as "kielipainotus_sv"
,coalesce((select 1 from varda_kielipainotus where toimipaikka_id=varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09') and upper(kielipainotus_koodi)='EN'),0)::boolean as "kielipainotus_en"
,(select upper(kielipainotus_koodi) from varda_kielipainotus where toimipaikka_id=varda_toimipaikka.id
  and current_timestamp between coalesce(alkamis_pvm,'1900-01-01') and coalesce(paattymis_pvm,'9999-09-09')
  and upper(kielipainotus_koodi) NOT in ('FI','SV','EN')
  order by upper(kielipainotus_koodi) limit 1) as "kielipainotus_muu"
,varda_toimipaikka.alkamis_pvm
,varda_toimipaikka.paattymis_pvm
,varda_vakajarjestaja.organisaatio_oid as jarjestaja_oid
,varda_vakajarjestaja.nimi as jarjestaja_nimi
,varda_vakajarjestaja.y_tunnus as jarjestaja_y_tunnus
,varda_vakajarjestaja.yritysmuoto as jarjestaja_yritysmuoto
,varda_vakajarjestaja.ytjkieli as jarjestaja_ytjkieli
,varda_vakajarjestaja.kayntiosoite as jarjestaja_kayntiosoite
,varda_vakajarjestaja.kayntiosoite_postinumero as jarjestaja_kayntiosoite_postinumero
,varda_vakajarjestaja.kayntiosoite_postitoimipaikka as jarjestaja_kayntiosoite_postitoimipaikka
,varda_vakajarjestaja.alkamis_pvm as jarjestaja_alkamis_pvm
,varda_vakajarjestaja.paattymis_pvm as jarjestaja_paattymis_pvm
from varda_toimipaikka
join varda_vakajarjestaja on varda_vakajarjestaja.id=varda_toimipaikka.vakajarjestaja_id

create or replace view varda_rap_ohjaajasuhde as
select 
(select organisaatio_oid from varda_toimipaikka where varda_toimipaikka.id = varda_ohjaajasuhde.toimipaikka_id) as "toimipaikka_oid"
,varda_ohjaajasuhde.alkamis_pvm
,varda_ohjaajasuhde.paattymis_pvm
,varda_ohjaajasuhde.tyoaika_viikossa
,varda_ohjaajasuhde.tyotehtava_koodi
,varda_henkilo.henkilo_oid
,varda_henkilo.syntyma_pvm
,varda_henkilo.sukupuoli_koodi
,varda_tyontekija.tyosuhde_koodi
,varda_tyontekija.tutkintonimike_koodi
,varda_tyontekija.tyoaika_koodi
,varda_henkilo.aidinkieli_koodi
,varda_henkilo.katuosoite
,varda_henkilo.kotikunta_koodi
,varda_henkilo.postinumero
,varda_henkilo.postitoimipaikka
,count(distinct varda_taydennyskoulutus.suoritus_pvm) as taydennyskoulutus_lkm
,sum(varda_taydennyskoulutus.tuntimaara) as taydennyskoulutus_tuntimaara
from varda_ohjaajasuhde
join varda_tyontekija on varda_tyontekija.id=varda_ohjaajasuhde.tyontekija_id
join varda_henkilo on varda_henkilo.id=varda_tyontekija.henkilo_id
left join varda_taydennyskoulutus on varda_taydennyskoulutus.tyontekija_id = varda_tyontekija.id
group by
varda_ohjaajasuhde.toimipaikka_id
,varda_ohjaajasuhde.alkamis_pvm
,varda_ohjaajasuhde.paattymis_pvm
,varda_ohjaajasuhde.tyoaika_viikossa
,varda_ohjaajasuhde.tyotehtava_koodi
,varda_henkilo.henkilo_oid
,varda_henkilo.syntyma_pvm
,varda_henkilo.sukupuoli_koodi
,tyosuhde_koodi
,tutkintonimike_koodi
,tyoaika_koodi
,varda_henkilo.aidinkieli_koodi
,varda_henkilo.katuosoite
,varda_henkilo.kotikunta_koodi
,varda_henkilo.postinumero
,varda_henkilo.postitoimipaikka

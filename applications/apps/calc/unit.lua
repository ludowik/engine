-- Unit

unites = {
    {
        name = 'devise',
        abrev = 'devise',
        
        uniteSaisie = "Euro",
        uniteConvertie = "FF",
        
        {name="Euro"  , abrev="Euro", coef=1},
        {name="Francs", abrev="FF"  , coef=6.55957},
        {name="Dollar", abrev="USD" , coef=1.1385},
    },
    
    {
        name = 'Unites de vitesse',
        abrev = 'vitesse',
        
        uniteSaisie = "m/s",
        uniteConvertie = "noeud",
        
        {name="m/s"    , abrev="m/s"   , coef=1/3.600},
        {name="k/s"    , abrev="k/s"   , coef=1/3600},
        {name="k/h"    , abrev="k/h"   , coef=1},
        {name="noeud"  , abrev="noeud" , coef=1/1.852},
    },
    
    {
        name = 'Unites de longueur',
        abrev = 'longueur',
        
        uniteSaisie = "m",
        uniteConvertie = "cm",
        
        {name="km"        , abrev="km"   , coef=0.001},
        {name="hm"        , abrev="hm"   , coef=0.01},
        {name="dam"       , abrev="dam"  , coef=0.1},
        {name="m"         , abrev="m"    , coef=1},
        {name="dm"        , abrev="dm"   , coef=10},
        {name="cm"        , abrev="cm"   , coef=100},
        {name="mm"        , abrev="mm"   , coef=1000},
        
        {name="pouce"     , abrev="pouce", coef=1/0.0254},
        {name="pied"      , abrev="pied" , coef=1/0.3048},
        
        {name="mille"     , abrev="mille", coef=1/1.852},
        
        {name="nanometre" , abrev="nm"   , coef=10^9},
        {name="angstrom"  , abrev="a"    , coef=10^10},
        {name="picometre" , abrev="pm"   , coef=10^12},
        {name="femtometre", abrev="fm"   , coef=10^15},
       
    }
}

function setupUnit()
    table.forEach(unites, function (uniteDe)
        unites[uniteDe.abrev] = uniteDe
        table.forEach(uniteDe, function (unite)
            uniteDe[unite.abrev] = unite
            if unite.coef == 1 then
                uniteDe.uniteDeBase = unite.abrev
            end
        end)
    end)
end

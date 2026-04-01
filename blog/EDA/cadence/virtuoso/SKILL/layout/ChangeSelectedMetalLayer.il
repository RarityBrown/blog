procedure( ChangeSelectedMetalLayer(targetNum)
    let((sel layerName purpose newLayerName)
        sel = geGetSelSet()
        foreach(obj sel
            printf("Selected object type: %s\n" obj~>objType)
            if(member(obj~>objType '("rect" "path" "pathSeg" "label")) then
                layerName = obj~>layerName
                purpose = obj~>purpose
                if(layerName && rexMatchp("^M[0-9]+$" layerName) then
                    newLayerName = sprintf(nil "M%d" targetNum)
                    obj~>lpp = list(newLayerName purpose)
                )
            )
        )
    )
)

for(i 1 9
    hiSetBindKey("Layout" sprintf(nil "<Key>%d" i) sprintf(nil "ChangeSelectedMetalLayer(%d)" i))
)

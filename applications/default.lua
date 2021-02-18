function draw()
    background(white)
    noFill();
stroke(255, 102, 0);
bezier(5, 26, 5, 26, 73, 24, 73, 61);
stroke(0);
bezier(5, 26, 73, 24, 73, 61, 15, 65);
stroke(255, 102, 0);
bezier(73, 24, 73, 61, 15, 65, 15, 65);
end

function bezier(x1, y1, x2, y2, x3, y3, x4, y4)
    local f = bezier_proc({x1,x2,x3,x4}, {y1,y2,y3,y4})
    strokeWidth(5)
    for i=0,1,0.01 do 
        point(f(i))
    end
end

--[[a parametric function describing the Bezier curve determined by given control points,
which takes t from 0 to 1 and returns the x, y of the corresponding point on the Bezier curve]]
function bezier_proc(xv, yv)
    local reductor = {__index = function(self, ind)
            return setmetatable({tree = self, level = ind}, {__index = function(curves, ind)
                        return function(t)
                            local x1, y1 = curves.tree[curves.level-1][ind](t)
                            local x2, y2 = curves.tree[curves.level-1][ind+1](t)
                            return x1 + (x2 - x1) * t, y1 + (y2 - y1) * t
                        end
                    end})
        end
    }
    local points = {}
    for i = 1, #xv do
        points[i] = function(t) return xv[i], yv[i] end
    end
    return setmetatable({points}, reductor)[#points][1]
end

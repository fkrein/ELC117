import Text.Printf

type Point = (Float,Float)
type Rect = (Point,Float,Float)

writeRect :: (String,Rect) -> String 
writeRect (style,((x,y),w,h)) = printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

writeRects :: Float -> Float -> [(String,Rect)] -> String
writeRects w h rs = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 
                    ++ (concatMap writeRect rs) ++ "</svg>"

main :: IO ()
main = do
  let
    hue = 240
    width = 50
    height = 20
    lines = 10
    columns = 5
    (w,h) = (width * columns, height * lines)
    elem_list = [(line,column)| line <- [1..lines], column <- [1..columns]]
    coor_list = map (\n-> ((snd n - 1) * width, (fst n - 1) * height) ) elem_list
    style_list = map (\n-> (100 - ((snd n - 1) * (100 / (columns - 1))),
                     100 - ((fst n - 1) * (100 / (lines - 1))))) elem_list
    style = map (\n-> "fill:hsl(240," ++ show (fst n) ++ "%," ++ show (snd n) ++ "%);stroke-width:2;stroke:gray") style_list
    zipped = zip style coor_list
    rects = map (\n-> (fst n,(snd n,width,height)) ) zipped
  writeFile "colors.svg" (writeRects w h rects)
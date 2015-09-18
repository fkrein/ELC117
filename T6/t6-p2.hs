import Text.Printf

type Point = (Float,Float)
type Rect = (Point,Float,Float)

calcRects :: Int -> Float -> Float -> Float -> Float -> Float -> Float -> [(String,Rect)]
calcRects hue width height lines columns initX initY = do
	let	elem_list = [(line,column)| line <- [1..lines], column <- [1..columns]]
	let	coor_list = map (\n-> (((snd n - 1) * width) + initX, ((fst n - 1) * height) + initY) ) elem_list
	let	style_list = map (\n-> (100 - ((snd n-1) * (100 / (columns-1))),100 - ((fst n - 1) * (100 / (lines - 1))))) elem_list
	let style = map (\n-> "fill:hsl(" ++ show hue ++ "," ++ show (fst n) ++"%," 
                  ++ show (snd n) ++"%);stroke-width:2;stroke:gray") style_list
	let	zipped = zip style coor_list
	map (\n-> (fst n,(snd n,width,height))) zipped

calcPosit :: Float -> Float -> Float -> Float -> Float -> Float -> Float -> [[(String,Rect)]]
calcPosit quantity qtt width height lines columns space = do
    let elem_list = [(line,column)| line<-[1..qtt], column<-[1..qtt], 
                    if qtt*qtt-qtt<(quantity) then line <= qtt else line < qtt,
                    if (qtt*qtt-qtt<(quantity) && line == qtt) then column <= (quantity) - (qtt - 1) * qtt else True,
                    if not(qtt*qtt-qtt<(quantity)) && line == qtt - 1 then column <= (quantity) - (qtt - 2) * qtt else True]
        coor_list = map (\n-> (width*columns*(snd n - 1)+(snd n - 1)*space, 
                    height*lines*(fst n - 1)+(fst n - 1)*space)) elem_list
        style_list = map (\n-> round((fst n - 1)*qtt*(360/quantity)+(snd n)*(360/quantity))) elem_list
        zipped = zip style_list coor_list
    map (\n-> calcRects (fst n) width height lines columns (fst (snd n)) (snd (snd n))) zipped

writeRect' :: (String,Rect) -> String
writeRect' (style,((x,y),w,h)) = printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

writeRect :: [(String,Rect)] -> String
writeRect rs = concatMap writeRect' rs

writeRects :: Float -> Float -> [[(String,Rect)]] -> String
writeRects w h rs = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 
                    ++ (concatMap writeRect rs) ++ "</svg>"

main :: IO ()
main = do
  let
    quantity = 16
    space = 10
    width = 50
    height = 20
    lines = 8
    columns = 5
    qtt = fromIntegral (ceiling (sqrt quantity))
    (w,h) = (width*columns * qtt + (qtt-1)*space, height*lines * (if qtt*qtt-qtt<quantity then qtt else qtt-1)
            + (if qtt*qtt-qtt<quantity then qtt-1 else qtt-2)*space)
    rects = calcPosit quantity qtt width height lines columns space
  writeFile "colors.svg" (writeRects w h rects)
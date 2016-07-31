function Y = hu_first(bt_hu_classifierObs)

bt = screencapture(0, [565,406,25,25]);
bt_gray = rgb_to_gray(bt);
bt_there = extractHOGFeatures(bt_gray,'CellSize',[4 4]);
Y = predict(bt_hu_classifierObs,bt_there);


end
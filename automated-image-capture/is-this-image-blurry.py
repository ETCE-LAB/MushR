#  Copyright (C) 2022, 2023 Anant Sujatanagarjuna

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.

#  You should have received a copy of the GNU Affero General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.

import cv2
import numpy as np
imgs = ["/home/mushr/mushrimg/20220920_100001.jpg",
        "/home/mushr/mushrimg/20220920_200001.jpg",
        "/home/mushr/mushrimg/20220920_150001.jpg",
        "/home/mushr/mushrimg/20220920_210001.jpg",
        "/home/mushr/mushrimg/20220920_220001.jpg"]

def non_fogginess(imagefile):
    img = cv2.imread(imagefile)
    return np.var(img)/np.mean(img)

for filename in imgs:
    print(filename, non_fogginess(filename))

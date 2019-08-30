# -*- coding: utf-8 -*-
#
# 视频检测
# Author: alex
# Created Time: 2019年08月30日 星期五 20时13分09秒
import cv2
from openpose_image import get_openpose

openpose = get_openpose()


def image_detect(img):
    _, output_image = openpose.forward(img, True)
    return output_image


if __name__ == '__main__':
    import sys
    video_path = sys.argv[1]
    vc = cv2.VideoCapture(video_path)
    if vc.isOpened() is False:
        raise Exception('video open false!')

    fps = vc.get(cv2.CAP_PROP_FPS)
    size = (int(vc.get(cv2.CAP_PROP_FRAME_WIDTH)),
            int(vc.get(cv2.CAP_PROP_FRAME_HEIGHT)))
    print('fps: ', fps)
    print('size: ', size)
    fourcc = cv2.VideoWriter_fourcc(*'XVID')
    out = cv2.VideoWriter('output.avi', fourcc, fps, size)
    i = 0
    while True:
        rval, frame = vc.read()
        if rval is False:
            break

        image = image_detect(frame)
        out.write(image)
        i += 1
        if i % 100 == 0:
            print('    i: ', i)

    print('Total: ', i)
    vc.release()
    if out is not None:
        out.release()

    cv2.destroyAllWindows()

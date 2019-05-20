# Persons Counting by Head Detection in Real Time
Persons counting in real-time is achieved by mainly two steps, head detection and tracking the detected heads for exact count. 

Head detection is achieved by building a head detector. Our head detector contains combination of two classifiers. The two classifiers are trained using two different features, Haar and histogram of oriented gradients features (HOG) separately. Both the classifiers are trained by adaboost learning algorithm. Haar-like features are fast to compute but have low detection accuracy and HOG features have high detection accuracy but slow computation speed. Hence, using these two features, the detector can have high accuracy and fast speed. Fast speed gives the advantage of detecting heads in real-time. 

The head regions detected by head detector are then tracked using Kanade-Lucas-Tomasi tracker. The detected heads are identified by serial numbers. So, as more headsare detected the serial number increments accordingly. Hence, the last or highest number will be the total number of heads that are detected which indeed is the count of people. 

Developed two GUIs. One for Head detection from an image which can be either uploaded or by capturing from system's default camera and the other to count persons by detecting head of persons in real-time video that is being captured from system's default camera. Also used PTZ camera to get images and live feed. 

HeadDetect.fig  - GUI for detecting heads in an Image.

HeadCount.fig  - GUI for counting heads in a video/Live stream.

Haar.xml and Head6.xml are the two classifiers obtained after training a huge head dataset. One is derived from Haar classification and the other from HOG classification. 

Used Matlab's Computer Vision Toolbox and Image Processing Toolbox.

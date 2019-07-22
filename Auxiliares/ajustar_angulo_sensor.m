function ajustar_angulo_sensor(angulo)

imaqreset

% colorVid = videoinput('kinect',1)
depthVid = videoinput('kinect',2);

triggerconfig(depthVid,'manual');
depthVid.FramesPerTrigger = 1;
depthVid.TriggerRepeat = inf;
set(getselectedsource(depthVid), 'TrackingMode', 'Skeleton')

viewer = vision.DeployableVideoPlayer();

src = getselectedsource(depthVid);
src.CameraElevationAngle = angulo;


end


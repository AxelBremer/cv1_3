[vx_synth, vy_synth, axes_synth] = lucas_kanade('synth1.pgm', 'synth2.pgm');
[vx_sphere, vy_sphere, axes_sphere] = lucas_kanade('sphere1.ppm', 'sphere2.ppm');

figure
subplot(1,2,1);
quiver(axes_synth, axes_synth, vx_synth, vy_synth);
title('Synth');
subplot(1,2,2);
quiver(axes_sphere, axes_sphere, vx_sphere, vy_sphere);
title('Sphere');
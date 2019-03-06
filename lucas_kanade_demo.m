[vx_synth, vy_synth, axes_synth, image1_synth, image2_synth] = lucas_kanade('synth1.pgm', 'synth2.pgm');
[vx_sphere, vy_sphere, axes_sphere, image1_sphere, image2_sphere] = lucas_kanade('sphere1.ppm', 'sphere2.ppm');

figure
subplot(1,2,1);
imshow(image1_synth);
hold on;
quiver(axes_synth, axes_synth, vx_synth, vy_synth, 'color',[1 0 0]);
title('Synth.pgm with flow vector arrows');
subplot(1,2,2);
imshow(image1_sphere);
hold on;
quiver(axes_sphere, axes_sphere, vx_sphere, vy_sphere, 'color',[1 0 0]);
title('Sphere.ppm with flow vector arrows');

figure
subplot(2,3,1);
imshow(image1_synth);
title('Original Synth1.pgm');
subplot(2,3,2);
quiver(axes_synth, -axes_synth, vx_synth, -vy_synth, 'color',[1 0 0]);
title('Flow vectors of difference Synth1.pgm and Synth1.pgm');
subplot(2,3,3);
imshow(image2_synth);
title('Original Synth2.pgm');
subplot(2,3,4);
imshow(image1_sphere);
title('Original Sphere1.ppm');
subplot(2,3,5);
quiver(axes_sphere, -axes_sphere, vx_sphere, -vy_sphere, 'color',[1 0 0]);
title('Flow vectors of difference Sphere1.ppm and Sphere1.ppm');
subplot(2,3,6);
imshow(image1_sphere);
title('Original Sphere2.ppm');
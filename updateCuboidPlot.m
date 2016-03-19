function updateCuboidPlot(plotHandle, center, orientation, depth, width, height)

    x_cuboid = orientation(:, 1);
    y_cuboid = orientation(:, 2);
    z_cuboid = orientation(:, 3);
    
%     f = front
%     b = back
%     l = left
%     r = right
%     c = ceiling
%     g = ground
    
    flg = center - depth*x_cuboid - width*y_cuboid - height*z_cuboid;
    flc = center - depth*x_cuboid - width*y_cuboid + height*z_cuboid;
    frg = center - depth*x_cuboid + width*y_cuboid - height*z_cuboid;
    frc = center - depth*x_cuboid + width*y_cuboid + height*z_cuboid;
    blg = center + depth*x_cuboid - width*y_cuboid - height*z_cuboid;
    blc = center + depth*x_cuboid - width*y_cuboid + height*z_cuboid;
    brg = center + depth*x_cuboid + width*y_cuboid - height*z_cuboid;
    brc = center + depth*x_cuboid + width*y_cuboid + height*z_cuboid;

    set ...
    ( ...
      plotHandle, ...
      'xdata', [flg(1), flc(1), frc(1), frg(1), blg(1), blc(1), brc(1), brg(1)], ...
      'ydata', [flg(2), flc(2), frc(2), frg(2), blg(2), blc(2), brc(2), brg(2)], ...
      'zdata', [flg(3), flc(3), frc(3), frg(3), blg(3), blc(3), brc(3), brg(3)] ...
    );













end
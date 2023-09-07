function [xc, yc, zc] = get_center(A, B, C)
    %%This function performs a vectorial approach for finding the center
    %%coordinates of a circle in space by entering three vectors containing
    %%the coordinates of three points in the circunference of the circle
    vAB = get_V_f_2_p(A, B);
    vAC = get_V_f_2_p(A, C);
    vBA = get_V_f_2_p(B, A);
    vBC = get_V_f_2_p(B, C);
    plane_dir = cross_product(vAC, vAB);
    perpbis1 = cross_product(vAB, plane_dir);
    perpbis2 = cross_product(vBC, plane_dir);
    [magperpbis1 uniperpbis1] = get_mag_uni_V(perpbis1);
    [magperpbis2 uniperpbis2] = get_mag_uni_V(perpbis2);
    [xm1 ym1 zm1] = get_mid_point(A, B);
    [xm2 ym2 zm2] = get_mid_point(B, C);
    
    alfa1 = uniperpbis1(1, 1);
    beta1 = uniperpbis1(1, 2);
    gama1 = uniperpbis1(1, 3);
    alfa2 = uniperpbis2(1, 1);
    beta2 = uniperpbis2(1, 2);
    gama2 = uniperpbis2(1, 3);

    
    if alfa1*beta2 - alfa2*beta1 ~= 0
        c1 = (beta2*(xm2 - xm1) + alfa2*(ym1 - ym2))/(alfa1*beta2 - alfa2*beta1);
        c2 = (xm1 + c1*alfa1 - xm2)/alfa2;
    elseif alfa1*gama2 - alfa2*gama1 ~= 0
        c1 = (gama2*(xm2 - xm1) + alfa2*(zm1 - zm2))/(alfa1*gama2 - alfa2*gama1);
        c2 = (xm1 + c1*alfa1 - xm2)/alfa2;
    else
        c1 = (gama2*(ym2 - ym1) + beta2*(zm1 - zm2))/(beta1*gama2 - beta2*gama1);
        c2 = (ym1 + c1*beta1 - ym2)/beta2;
    end
    
    
    % xc = xm1 + c1*alfa1;
    % yc = ym1 + c1*beta1;
    % zc = zm1 + c1*gama1;

    xc = xm2 + c2*alfa2;
    yc = ym2 + c2*beta2;
    zc = zm2 + c2*gama2;

end
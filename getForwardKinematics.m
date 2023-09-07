function y = getForwardKinematics(Theta) 
    xtheta = Theta(1, 1); 
    ytheta = Theta(1, 2);
    ztheta = Theta(1, 3);
    btheta = Theta(1, 4);
    ctheta = Theta(1, 5);
    %% Forward_Kinematics_Main_File
    P1095=319.870;P1096=-371.846;P1097=-343.700;
    G54_X=319.870;G54_Y=-371.846;G54_Z=-274.700;
    SJointAxis.fX=xtheta;
    SJointAxis.fY=ytheta;
    SJointAxis.fZ=ztheta;
    SJointAxis.fBangle=btheta;
    SJointAxis.fCangle=ctheta;
    %%%%%%
    SJointAxis.fAangle=0;
    e_LeftHand=-1;
    SMachineGeometry.fLx=P1095-G54_X;
    SMachineGeometry.fLy=P1096-G54_Y;
    SMachineGeometry.fLz=P1097-G54_Z;
    SMachineGeometry.fMx=0.033;
    SMachineGeometry.fMy=0.033;
    SMachineGeometry.fMz=-70.192;
    SMachineGeometry.fWx=0;
    SMachineGeometry.fWy=1;
    SMachineGeometry.fWz=0;
    SMachineGeometry.fMx=0.033;
    SMachineGeometry.fToolLength=120;
    y=Forward_Kinematics(SJointAxis,SMachineGeometry,e_LeftHand);
end
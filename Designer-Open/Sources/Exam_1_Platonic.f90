!
! ---------------------------------------------------------------------------------------
!
!                               Module for Exam_Platonic
!
!                                             Programmed by Hyungmin Jun (hmjeon@mit.edu)
!                                                   Massachusetts Institute of Technology
!                                                    Department of Biological Engineering
!                                         Laboratory for computational Biology & Biophics
!                                                             First modified : 2015/08/03
!                                                             Last  modified : 2016/07/14
!
! ---------------------------------------------------------------------------------------
!
module Exam_Platonic

    use Data_Prob
    use Data_Geom

    use Mani

    implicit none

    public Exam_Platonic_Tetrahedron        ! 1. V=4,  E=6,  F=4
    public Exam_Platonic_Cube               ! 2. V=8,  E=12, F=6
    public Exam_Platonic_Octahedron         ! 3. V=6,  E=12, F=8
    public Exam_Platonic_Dodecahedron       ! 4. V=20, E=30, F=12
    public Exam_Platonic_Icosahedron        ! 5. V=12, E=30, F=20

    public Exam_Asym_Tetra_I_63_73_52_42    ! 59. V=4,  E=6,  F=4
    public Exam_Asym_Tetra_II_63_52_42      ! 60. V=4,  E=6,  F=4
    public Exam_Asym_Tetra_III_63_42        ! 61. V=4,  E=6,  F=4

contains

! ---------------------------------------------------------------------------------------

! Example of Tetrahedron
! Last updated on Wednesday 16 Mar 2016 by Hyungmin
subroutine Exam_Platonic_Tetrahedron(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "01_Tetrahedron"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Tetrahedron"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "min"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 1.0d0      ! Cylindrical model
    prob.move_x   =-1.0d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 4
    geom.n_face = 4

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.00000d0,  0.00000d0,  6.12374d0 ]
    geom.iniP(2).pos(1:3) = [  5.77351d0,  0.00000d0, -2.04125d0 ]
    geom.iniP(3).pos(1:3) = [ -2.88676d0,  5.00000d0, -2.04125d0 ]
    geom.iniP(4).pos(1:3) = [ -2.88676d0, -5.00000d0, -2.04125d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 2, 3 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 4, 2 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 4, 3 ]

    ! Sakul's tetraheron geometric information
    ! Set point position vectors
    !geom.iniP(1).pos(1:3) = [  0.000000d0,  0.000000d0,  0.612372d0 ]
    !geom.iniP(2).pos(1:3) = [ -0.288675d0, -0.500000d0, -0.204124d0 ]
    !geom.iniP(3).pos(1:3) = [ -0.288675d0,  0.500000d0, -0.204124d0 ]
    !geom.iniP(4).pos(1:3) = [  0.577350d0,  0.000000d0, -0.204124d0 ]

    ! Set face connnectivity
    !geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 3, 2 ]
    !geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 2, 4 ]
    !geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 4, 3 ]
    !geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 3, 4 ]
end subroutine Exam_Platonic_Tetrahedron

! ---------------------------------------------------------------------------------------

! Example of Cube
! Last updated on Friday 4 Mar 2016 by Hyungmin
subroutine Exam_Platonic_Cube(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "02_Cube"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Cube"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "min"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 0.7d0      ! Atomic model
    prob.size     = 1.00d0     ! Cylindrical model
    prob.move_x   = 0.0d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XYZ"

    ! allocate point, line and face structure
    geom.n_iniP = 8
    geom.n_face = 6

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [ -1.0d0, -1.0d0, -1.0d0 ]; geom.iniP(2).pos(1:3) = [  1.0d0, -1.0d0, -1.0d0 ]
    geom.iniP(3).pos(1:3) = [  1.0d0,  1.0d0, -1.0d0 ]; geom.iniP(4).pos(1:3) = [ -1.0d0,  1.0d0, -1.0d0 ]
    geom.iniP(5).pos(1:3) = [ -1.0d0, -1.0d0,  1.0d0 ]; geom.iniP(6).pos(1:3) = [  1.0d0, -1.0d0,  1.0d0 ]
    geom.iniP(7).pos(1:3) = [  1.0d0,  1.0d0,  1.0d0 ]; geom.iniP(8).pos(1:3) = [ -1.0d0,  1.0d0,  1.0d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 4; allocate(geom.face(1).poi(4)); geom.face(1).poi(1:4) = [ 1, 4, 3, 2 ]
    geom.face(2).n_poi = 4; allocate(geom.face(2).poi(4)); geom.face(2).poi(1:4) = [ 5, 6, 7, 8 ]
    geom.face(3).n_poi = 4; allocate(geom.face(3).poi(4)); geom.face(3).poi(1:4) = [ 2, 3, 7, 6 ]
    geom.face(4).n_poi = 4; allocate(geom.face(4).poi(4)); geom.face(4).poi(1:4) = [ 1, 5, 8, 4 ]
    geom.face(5).n_poi = 4; allocate(geom.face(5).poi(4)); geom.face(5).poi(1:4) = [ 1, 2, 6, 5 ]
    geom.face(6).n_poi = 4; allocate(geom.face(6).poi(4)); geom.face(6).poi(1:4) = [ 3, 4, 8, 7 ]

    ! Set point position vectors
    !point(1).pos(1:3) = [  0.00000d0,  0.00000d0,  8.66030d0 ]; iniP(2).pos(1:3) = [  8.16497d0,  0.00000d0,  2.88675d0 ]
    !point(3).pos(1:3) = [ -4.08248d0,  7.07107d0,  2.88675d0 ]; iniP(4).pos(1:3) = [ -4.08248d0, -7.07107d0,  2.88675d0 ]
    !point(5).pos(1:3) = [  4.08248d0,  7.07107d0, -2.88675d0 ]; iniP(6).pos(1:3) = [  4.08248d0, -7.07107d0, -2.88675d0 ]
    !point(7).pos(1:3) = [ -8.16497d0,  0.00000d0, -2.88675d0 ]; iniP(8).pos(1:3) = [  0.00000d0,  0.00000d0, -8.66030d0 ]

    ! Set face connnectivity
    !face(1).n_poi = 4; allocate(face(1).poi(4)); face(1).poi(1:4) = [ 1, 2, 5, 3 ]
    !face(2).n_poi = 4; allocate(face(2).poi(4)); face(2).poi(1:4) = [ 1, 3, 7, 4 ]
    !face(3).n_poi = 4; allocate(face(3).poi(4)); face(3).poi(1:4) = [ 1, 4, 6, 2 ]
    !face(4).n_poi = 4; allocate(face(4).poi(4)); face(4).poi(1:4) = [ 2, 6, 8, 5 ]
    !face(5).n_poi = 4; allocate(face(5).poi(4)); face(5).poi(1:4) = [ 3, 5, 8, 7 ]
    !face(6).n_poi = 4; allocate(face(6).poi(4)); face(6).poi(1:4) = [ 4, 7, 8, 6 ]
end subroutine Exam_Platonic_Cube

! ---------------------------------------------------------------------------------------

! Example of Octahedron
! Last updated on Friday 4 Mar 2016 by Hyungmin
subroutine Exam_Platonic_Octahedron(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "03_Octahedron"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Octahedron"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "min"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
        para_n_base_tn       = 7
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 1.0d0      ! Cylindrical model
    prob.move_x   = -1.0d0     ! Cylindrical model
    prob.move_y   = -1.0d0     ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 6
    geom.n_face = 8

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.00000d0,  0.00000d0,  7.07107d0 ]
    geom.iniP(2).pos(1:3) = [  7.07107d0,  0.00000d0,  0.00000d0 ]
    geom.iniP(3).pos(1:3) = [  0.00000d0,  7.07107d0,  0.00000d0 ]
    geom.iniP(4).pos(1:3) = [ -7.07107d0,  0.00000d0,  0.00000d0 ]
    geom.iniP(5).pos(1:3) = [  0.00000d0, -7.07107d0,  0.00000d0 ]
    geom.iniP(6).pos(1:3) = [  0.00000d0,  0.00000d0, -7.07107d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 2, 3 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 4, 5 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 1, 5, 2 ]
    geom.face(5).n_poi = 3; allocate(geom.face(5).poi(3)); geom.face(5).poi(1:3) = [ 2, 5, 6 ]
    geom.face(6).n_poi = 3; allocate(geom.face(6).poi(3)); geom.face(6).poi(1:3) = [ 2, 6, 3 ]
    geom.face(7).n_poi = 3; allocate(geom.face(7).poi(3)); geom.face(7).poi(1:3) = [ 3, 6, 4 ]
    geom.face(8).n_poi = 3; allocate(geom.face(8).poi(3)); geom.face(8).poi(1:3) = [ 4, 6, 5 ]
end subroutine Exam_Platonic_Octahedron

! ---------------------------------------------------------------------------------------

! Example of Dodecahedron
! Last updated on Friday 4 Mar 2016 by Hyungmin
subroutine Exam_Platonic_Dodecahedron(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp
    
    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "04_Dodecahedron"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Dodecahedron"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "min"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 0.95d0     ! Cylindrical model
    prob.move_x   = 3.0d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 20
    geom.n_face = 12

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP( 1).pos(1:3) = [   0.00000d0,   0.00000d0,  14.01264d0 ]; geom.iniP( 2).pos(1:3) = [   9.34173d0,   0.00000d0,  10.44437d0 ]
    geom.iniP( 3).pos(1:3) = [  -4.67086d0,   8.09018d0,  10.44437d0 ]; geom.iniP( 4).pos(1:3) = [  -4.67086d0,  -8.09018d0,  10.44437d0 ]
    geom.iniP( 5).pos(1:3) = [  10.44437d0,   8.09018d0,   4.67086d0 ]; geom.iniP( 6).pos(1:3) = [  10.44437d0,  -8.09018d0,   4.67086d0 ]
    geom.iniP( 7).pos(1:3) = [ -12.22848d0,   5.00000d0,   4.67086d0 ]; geom.iniP( 8).pos(1:3) = [   1.78411d0,  13.09018d0,   4.67086d0 ]
    geom.iniP( 9).pos(1:3) = [   1.78411d0, -13.09018d0,   4.67086d0 ]; geom.iniP(10).pos(1:3) = [ -12.22848d0,  -5.00000d0,   4.67086d0 ]
    geom.iniP(11).pos(1:3) = [  12.22848d0,   5.00000d0,  -4.67086d0 ]; geom.iniP(12).pos(1:3) = [  12.22848d0,  -5.00000d0,  -4.67086d0 ]
    geom.iniP(13).pos(1:3) = [ -10.44437d0,   8.09018d0,  -4.67086d0 ]; geom.iniP(14).pos(1:3) = [  -1.78411d0,  13.09018d0,  -4.67086d0 ]
    geom.iniP(15).pos(1:3) = [  -1.78411d0, -13.09018d0,  -4.67086d0 ]; geom.iniP(16).pos(1:3) = [ -10.44437d0,  -8.09018d0,  -4.67086d0 ]
    geom.iniP(17).pos(1:3) = [   4.67086d0,   8.09018d0, -10.44437d0 ]; geom.iniP(18).pos(1:3) = [   4.67086d0,  -8.09018d0, -10.44437d0 ]
    geom.iniP(19).pos(1:3) = [  -9.34173d0,   0.00000d0, -10.44437d0 ]; geom.iniP(20).pos(1:3) = [   0.00000d0,   0.00000d0, -14.01264d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi  = 5; allocate(geom.face(1).poi(5));  geom.face( 1).poi(1:5) = [  1,  2,  5,  8,  3 ]
    geom.face(2).n_poi  = 5; allocate(geom.face(2).poi(5));  geom.face( 2).poi(1:5) = [  1,  3,  7, 10,  4 ]
    geom.face(3).n_poi  = 5; allocate(geom.face(3).poi(5));  geom.face( 3).poi(1:5) = [  1,  4,  9,  6,  2 ]
    geom.face(4).n_poi  = 5; allocate(geom.face(4).poi(5));  geom.face( 4).poi(1:5) = [  2,  6, 12, 11,  5 ]
    geom.face(5).n_poi  = 5; allocate(geom.face(5).poi(5));  geom.face( 5).poi(1:5) = [  3,  8, 14, 13,  7 ]
    geom.face(6).n_poi  = 5; allocate(geom.face(6).poi(5));  geom.face( 6).poi(1:5) = [  4, 10, 16, 15,  9 ]
    geom.face(7).n_poi  = 5; allocate(geom.face(7).poi(5));  geom.face( 7).poi(1:5) = [  5, 11, 17, 14,  8 ]
    geom.face(8).n_poi  = 5; allocate(geom.face(8).poi(5));  geom.face( 8).poi(1:5) = [  6,  9, 15, 18, 12 ]
    geom.face(9).n_poi  = 5; allocate(geom.face(9).poi(5));  geom.face( 9).poi(1:5) = [  7, 13, 19, 16, 10 ]
    geom.face(10).n_poi = 5; allocate(geom.face(10).poi(5)); geom.face(10).poi(1:5) = [ 11, 12, 18, 20, 17 ]
    geom.face(11).n_poi = 5; allocate(geom.face(11).poi(5)); geom.face(11).poi(1:5) = [ 13, 14, 17, 20, 19 ]
    geom.face(12).n_poi = 5; allocate(geom.face(12).poi(5)); geom.face(12).poi(1:5) = [ 15, 16, 19, 20, 18 ]
end subroutine Exam_Platonic_Dodecahedron

! ---------------------------------------------------------------------------------------

! Example of Icosahedron
! Last updated on Friday 4 Mar 2016 by Hyungmin
subroutine Exam_Platonic_Icosahedron(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "05_Icosahedron"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Icosahedron"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "min"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
        para_n_base_tn       = 7        ! [-1   ],   The number of nucleotides in poly T loop, -1 : depending on distance
        para_set_seq_scaf    = 1        ! [0, 1, 2], Scaffold sequence, 0 - M13mp18(7249nt), 1 - import sequence from seq.txt, 2 - random
        para_set_start_scaf  = 1        ! [7217, 4141], Starting nucleotide position of scaffold strand
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 1.05d0     ! Cylindrical model
    prob.move_x   =-0.5d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 12
    geom.n_face = 20

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP( 1).pos(1:3) = [  0.00000d0,  0.00000d0,  9.51058d0 ]; geom.iniP( 2).pos(1:3) = [  8.50650d0,  0.00000d0,  4.25326d0 ]
    geom.iniP( 3).pos(1:3) = [  2.62866d0,  8.09018d0,  4.25326d0 ]; geom.iniP( 4).pos(1:3) = [ -6.88192d0,  5.00001d0,  4.25326d0 ]
    geom.iniP( 5).pos(1:3) = [ -6.88192d0, -5.00001d0,  4.25326d0 ]; geom.iniP( 6).pos(1:3) = [  2.62866d0, -8.09018d0,  4.25326d0 ]
    geom.iniP( 7).pos(1:3) = [  6.88192d0,  5.00001d0, -4.25326d0 ]; geom.iniP( 8).pos(1:3) = [  6.88192d0, -5.00001d0, -4.25326d0 ]
    geom.iniP( 9).pos(1:3) = [ -2.62866d0,  8.09018d0, -4.25326d0 ]; geom.iniP(10).pos(1:3) = [ -8.50650d0,  0.00000d0, -4.25326d0 ]
    geom.iniP(11).pos(1:3) = [ -2.62866d0, -8.09018d0, -4.25326d0 ]; geom.iniP(12).pos(1:3) = [  0.00000d0,  0.00000d0, -9.51058d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi  = 3; allocate(geom.face(1).poi(3));  geom.face( 1).poi(1:3) = [  1,  2,  3 ]
    geom.face(2).n_poi  = 3; allocate(geom.face(2).poi(3));  geom.face( 2).poi(1:3) = [  1,  3,  4 ]
    geom.face(3).n_poi  = 3; allocate(geom.face(3).poi(3));  geom.face( 3).poi(1:3) = [  1,  4,  5 ]
    geom.face(4).n_poi  = 3; allocate(geom.face(4).poi(3));  geom.face( 4).poi(1:3) = [  1,  5,  6 ]
    geom.face(5).n_poi  = 3; allocate(geom.face(5).poi(3));  geom.face( 5).poi(1:3) = [  1,  6,  2 ]
    geom.face(6).n_poi  = 3; allocate(geom.face(6).poi(3));  geom.face( 6).poi(1:3) = [  2,  6,  8 ]
    geom.face(7).n_poi  = 3; allocate(geom.face(7).poi(3));  geom.face( 7).poi(1:3) = [  2,  8,  7 ]
    geom.face(8).n_poi  = 3; allocate(geom.face(8).poi(3));  geom.face( 8).poi(1:3) = [  2,  7,  3 ]
    geom.face(9).n_poi  = 3; allocate(geom.face(9).poi(3));  geom.face( 9).poi(1:3) = [  3,  7,  9 ]
    geom.face(10).n_poi = 3; allocate(geom.face(10).poi(3)); geom.face(10).poi(1:3) = [  3,  9,  4 ]
    geom.face(11).n_poi = 3; allocate(geom.face(11).poi(3)); geom.face(11).poi(1:3) = [  4,  9, 10 ]
    geom.face(12).n_poi = 3; allocate(geom.face(12).poi(3)); geom.face(12).poi(1:3) = [  4, 10,  5 ]
    geom.face(13).n_poi = 3; allocate(geom.face(13).poi(3)); geom.face(13).poi(1:3) = [  5, 10, 11 ]
    geom.face(14).n_poi = 3; allocate(geom.face(14).poi(3)); geom.face(14).poi(1:3) = [  5, 11,  6 ]
    geom.face(15).n_poi = 3; allocate(geom.face(15).poi(3)); geom.face(15).poi(1:3) = [  6, 11,  8 ]
    geom.face(16).n_poi = 3; allocate(geom.face(16).poi(3)); geom.face(16).poi(1:3) = [  7,  8, 12 ]
    geom.face(17).n_poi = 3; allocate(geom.face(17).poi(3)); geom.face(17).poi(1:3) = [  7, 12,  9 ]
    geom.face(18).n_poi = 3; allocate(geom.face(18).poi(3)); geom.face(18).poi(1:3) = [  8, 11, 12 ]
    geom.face(19).n_poi = 3; allocate(geom.face(19).poi(3)); geom.face(19).poi(1:3) = [  9, 12, 10 ]
    geom.face(20).n_poi = 3; allocate(geom.face(20).poi(3)); geom.face(20).poi(1:3) = [ 10, 12, 11 ]
end subroutine Exam_Platonic_Icosahedron

! ---------------------------------------------------------------------------------------

! Example of Asym Tetra I[63-63-63-73-52-42]
! Last updated on Tuesday 11 October 2016 by Hyungmin
subroutine Exam_Asym_Tetra_I_63_73_52_42(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    ! Fixed edge length as 42bp (minimum edge length)
    prob.sel_bp_edge = 2

    if(geom.sec.types == "square") then
        if(prob.sel_bp_edge == 1) prob.n_bp_edge = 32   ! 32bp * 1
        if(prob.sel_bp_edge == 2) prob.n_bp_edge = 43
        if(prob.sel_bp_edge == 3) prob.n_bp_edge = 53
        if(prob.sel_bp_edge == 4) prob.n_bp_edge = 64   ! 32bp * 2
    else if(geom.sec.types == "honeycomb") then
        if(prob.sel_bp_edge == 1) prob.n_bp_edge = 31
        if(prob.sel_bp_edge == 2) prob.n_bp_edge = 42   ! 21bp * 2
        if(prob.sel_bp_edge == 3) prob.n_bp_edge = 52
        if(prob.sel_bp_edge == 4) prob.n_bp_edge = 63   ! 21bp * 3
    end if

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "59_Asym_Tetra_I_63_73_52_42"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Asym Tetra I[63-63-63-73-52-42]"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
        para_n_base_tn       = 7        ! [-1     ], The number of nucleotides in poly T loop, -1 : depending on distance
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 1.0d0      ! Cylindrical model
    prob.move_x   = 0.0d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 4
    geom.n_face = 4

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.000000d0,  0.000000d0,  0.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0, 63.000000d0,  0.000000d0 ]
    geom.iniP(3).pos(1:3) = [ 59.499976d0, 20.706349d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [ 37.426315d0, 41.539683d0, 29.029739d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 4, 2 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 2, 3 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 4, 3 ]
end subroutine Exam_Asym_Tetra_I_63_73_52_42

! ---------------------------------------------------------------------------------------

! Example of Asym Tetra II[63-63-63-63-52-42]
! Last updated on Tuesday 11 October 2016 by Hyungmin
subroutine Exam_Asym_Tetra_II_63_52_42(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    ! Fixed edge length as 42bp (minimum edge length)
    prob.sel_bp_edge = 2

    if(geom.sec.types == "square") then
        if(prob.sel_bp_edge == 1) prob.n_bp_edge = 32   ! 32bp * 1
        if(prob.sel_bp_edge == 2) prob.n_bp_edge = 43
        if(prob.sel_bp_edge == 3) prob.n_bp_edge = 53
        if(prob.sel_bp_edge == 4) prob.n_bp_edge = 64   ! 32bp * 2
    else if(geom.sec.types == "honeycomb") then
        if(prob.sel_bp_edge == 1) prob.n_bp_edge = 31
        if(prob.sel_bp_edge == 2) prob.n_bp_edge = 42   ! 21bp * 2
        if(prob.sel_bp_edge == 3) prob.n_bp_edge = 52
        if(prob.sel_bp_edge == 4) prob.n_bp_edge = 63   ! 21bp * 3
    end if

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "60_Asym_Tetra_II_63_52_42"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Asym Tetra II[63-63-63-63-52-42]"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
        para_n_base_tn       = 7        ! [-1     ], The number of nucleotides in poly T loop, -1 : depending on distance
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 1.0d0      ! Cylindrical model
    prob.move_x   = 0.0d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 4
    geom.n_face = 4

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.000000d0,  0.000000d0,  0.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0, 63.000000d0,  0.000000d0 ]
    geom.iniP(3).pos(1:3) = [ 54.559600d0, 31.500000d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [ 32.597379d0, 41.539683d0, 34.363725d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 4, 2 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 2, 3 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 4, 3 ]
end subroutine Exam_Asym_Tetra_II_63_52_42

! ---------------------------------------------------------------------------------------

! Example of Asym Tetra III[63-63-63-63-63-42]
! Last updated on Tuesday 11 October 2016 by Hyungmin
subroutine Exam_Asym_Tetra_III_63_42(prob, geom)
    type(ProbType), intent(inout) :: prob
    type(GeomType), intent(inout) :: geom

    character(10) :: char_sec, char_bp, char_start_bp

    ! Fixed edge length as 42bp (minimum edge length)
    prob.sel_bp_edge = 2

    if(geom.sec.types == "square") then
        if(prob.sel_bp_edge == 1) prob.n_bp_edge = 32   ! 32bp * 1
        if(prob.sel_bp_edge == 2) prob.n_bp_edge = 43
        if(prob.sel_bp_edge == 3) prob.n_bp_edge = 53
        if(prob.sel_bp_edge == 4) prob.n_bp_edge = 64   ! 32bp * 2
    else if(geom.sec.types == "honeycomb") then
        if(prob.sel_bp_edge == 1) prob.n_bp_edge = 31
        if(prob.sel_bp_edge == 2) prob.n_bp_edge = 42   ! 21bp * 2
        if(prob.sel_bp_edge == 3) prob.n_bp_edge = 52
        if(prob.sel_bp_edge == 4) prob.n_bp_edge = 63   ! 21bp * 3
    end if

    write(unit=char_sec,      fmt = "(i10)"), prob.sel_sec
    write(unit=char_bp,       fmt = "(i10)"), prob.n_bp_edge
    write(unit=char_start_bp, fmt = "(i10)"), para_start_bp_ID

    prob.name_file = "61_Asym_Tetra_III_63_42"//&
        "_"//trim(adjustl(trim(char_sec)))//"cs"//&     ! Cross-section
        "_"//trim(adjustl(trim(char_bp)))//"bp"//&      ! Edge length
        "_"//trim(para_vertex_design)//&                ! Vertex design
        "_"//trim(para_vertex_modify)//&                ! Vertex modification
        "_"//trim(para_cut_stap_method)                 ! Cutting method

    prob.name_prob = "Asym Tetra III[63-63-63-63-63-42]"

    ! Problem specified preset parameters
    if(para_vertex_design == "flat" .and. para_preset == "on") then
        para_junc_ang        = "max"    ! [opt, max, ave, min], Junction gap modification for different arm angle
        para_const_edge_mesh = "on"     ! [off, on], Constant edge length from polyhedra mesh
        para_unpaired_scaf   = "off"    ! [on, off], Unpaired scaffold nucleotides
        para_n_base_tn       = 7        ! [-1     ], The number of nucleotides in poly T loop, -1 : depending on distance
    end if

    ! Set geometric type and view
    prob.color    = [52, 152, 219]
    prob.scale    = 1.0d0      ! Atomic model
    prob.size     = 1.0d0      ! Cylindrical model
    prob.move_x   = 0.0d0      ! Cylindrical model
    prob.move_y   = 0.0d0      ! Cylindrical model
    prob.type_geo = "closed"
    if(para_fig_view == "PRESET" .or. para_fig_view == "preset") para_fig_view = "XY"

    ! allocate point, line and face structure
    geom.n_iniP = 4
    geom.n_face = 4

    allocate(geom.iniP(geom.n_iniP))
    allocate(geom.face(geom.n_face))

    ! Set point position vectors
    geom.iniP(1).pos(1:3) = [  0.000000d0,  0.000000d0,  0.000000d0 ]
    geom.iniP(2).pos(1:3) = [  0.000000d0, 63.000000d0,  0.000000d0 ]
    geom.iniP(3).pos(1:3) = [ 54.559600d0, 31.500000d0,  0.000000d0 ]
    geom.iniP(4).pos(1:3) = [ 38.393793d0, 31.500000d0, 38.764245d0 ]

    ! Set face connnectivity
    geom.face(1).n_poi = 3; allocate(geom.face(1).poi(3)); geom.face(1).poi(1:3) = [ 1, 4, 2 ]
    geom.face(2).n_poi = 3; allocate(geom.face(2).poi(3)); geom.face(2).poi(1:3) = [ 1, 3, 4 ]
    geom.face(3).n_poi = 3; allocate(geom.face(3).poi(3)); geom.face(3).poi(1:3) = [ 1, 2, 3 ]
    geom.face(4).n_poi = 3; allocate(geom.face(4).poi(3)); geom.face(4).poi(1:3) = [ 2, 4, 3 ]
end subroutine Exam_Asym_Tetra_III_63_42

! ---------------------------------------------------------------------------------------

end module Exam_Platonic
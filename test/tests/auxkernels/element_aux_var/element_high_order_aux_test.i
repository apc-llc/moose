[Mesh]
  file = square.e
[]

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./high_order]
    order = NINTH
    family = MONOMIAL
  [../]
  [./one]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  # Coupling of nonlinear to Aux
  [./diff]
    type = Diffusion
    variable = u
  [../]
  [./force]
    type = CoupledForce
    variable = u
    v = one
  [../]
[]

[AuxKernels]
  [./coupled_high_order]
    variable = high_order
    type = CoupledAux
    value = 2
    operator = +
    coupled = u
  [../]
  [./constant]
    variable = one
    type = ConstantAux
    value = 1
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = 1
    value = 0
  [../]
  [./right]
    type = DirichletBC
    variable = u
    boundary = 2
    value = 1
  [../]
[]

[Executioner]
  type = Steady

  # Preconditioned JFNK (default)
  solve_type = 'PJFNK'
[]

[Postprocessors]
 [./int2_u]
   type = ElementL2Norm
   variable = u
 [../]
 [./int2_ho]
   type = ElementL2Norm
   variable = high_order
 [../]
 [./int_u]
   type = ElementIntegralVariablePostprocessor
   variable = u
 [../]
 [./int_ho]
   type = ElementIntegralVariablePostprocessor
   variable = high_order
 [../]
[]

[Output]
  file_base = ho
  output_initial = true
  elemental_as_nodal = true
  interval = 1
  exodus = true
  perf_log = true
[]

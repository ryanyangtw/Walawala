
collection @episodes ,:root => "episodes"
#cache @episodes

extends("v1/episodes/_episode", locals: { show_parengt_program: true })


import argparse
from jinja2 import Template

def main(args):
   s = None
   with open("Dockerfile.jinja") as dockerfile_template:
      dockerfile_template_string = dockerfile_template.read()
      t = Template(dockerfile_template_string)
      s = t.render(tag=args.stag)
   if s != None:
      with open("Dockerfile." + args.stag,"w") as dockerfile: dockerfile.write(s)

parser = argparse.ArgumentParser()
parser.add_argument('template', help="source template filename")
parser.add_argument('stag', help="source tag")

args = parser.parse_args()
main(args)


import collections

Point = collections.namedtuple('Point',['x','y'])

p1 = Point(x=1,y=1)
p1 = p1+2
p2 = Point(x=2,y=3)
print(p1)
class PlanetInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  PlanetInfo(
      this.position, {
        this.name,
        this.iconImage,
        this.description,
        this.images,
      });
}

List<PlanetInfo> planets = [
  PlanetInfo(1,
      name: 'Paper',
      iconImage: 'assets/earth.png',
      description:
      "Recycled paper is a great source of paper fibres. Incorporating a mixture of recycled paper fibre reduces the number of trees being cut down.",
      images: [
        'https://cdn.pixabay.com/photo/2014/12/27/15/34/notebook-581128_1280.jpg',
        'https://cdn.pixabay.com/photo/2016/08/23/12/37/files-1614223_1280.jpg',
        'https://cdn.pixabay.com/photo/2018/03/25/13/43/garbage-3259455_1280.jpg',
      ]),
  PlanetInfo(2,
      name: 'Plastic',
      iconImage: 'assets/earth.png',
      description:
      "After processing, the plastic strands are cut into pellets to be used as material for new products. ",
      images: [
        'https://cdn.pixabay.com/photo/2011/12/13/14/39/venus-11022_1280.jpg',
        'https://image.shutterstock.com/image-photo/solar-system-venus-second-planet-600w-515581927.jpg'
      ]),
  PlanetInfo(3,
      name: 'Glass',
      iconImage: 'assets/earth.png',
      description:
      "Recycled glass are cleaned and crushed into cullets, which are melted to form new products. ",
      images: [
        'https://cdn.pixabay.com/photo/2012/10/09/05/53/bottles-60479_1280.jpg',
        'https://cdn.pixabay.com/photo/2020/05/04/10/31/the-bottle-5128607_1280.jpg',
        'https://cdn.pixabay.com/photo/2018/07/15/21/04/recycle-3540561_1280.jpg'
      ]),
  PlanetInfo(4,
      name: 'Metal',
      iconImage: 'assets/earth.png',
      description:
      "Recycled metals are sorted into ferrous and non-ferrous, and compacted, forming new products  ",
      images: [
        'https://cdn.pixabay.com/photo/2016/09/18/20/51/cans-1679022_1280.jpg',
        'https://cdn.pixabay.com/photo/2015/07/27/15/19/coca-cola-862689_1280.jpg',
        'https://cdn.pixabay.com/photo/2014/03/19/21/04/tin-cans-program-290869_1280.jpg'
      ]),

];
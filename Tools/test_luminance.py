import unittest

from PIL import Image

from luminance import luminance, point, zone


class Luminance(unittest.TestCase):
    def testLeBlancVaut255EtLeNoirZero(self):
        self.assertAlmostEqual(luminance((255, 255, 255)), 255.0, places=3)
        self.assertAlmostEqual(luminance((0, 0, 0)), 0.0, places=3)

    def testLaPondérationEstCelleDeRec709PasRec601(self):
        # Rec. 601 donnerait 76,245 sur le rouge pur et 149,685 sur le vert.
        self.assertAlmostEqual(luminance((255, 0, 0)), 54.213, places=3)
        self.assertAlmostEqual(luminance((0, 255, 0)), 182.376, places=3)
        self.assertAlmostEqual(luminance((0, 0, 255)), 18.411, places=3)

    def testUnPointSeLitAuxCoordonnéesDonnées(self):
        im = Image.new("RGB", (4, 4), (0, 0, 0))
        im.putpixel((3, 1), (255, 255, 255))
        self.assertAlmostEqual(point(im, 3, 1), 255.0, places=3)
        self.assertAlmostEqual(point(im, 0, 0), 0.0, places=3)

    def testUneZoneRendMoyenneMinEtMax(self):
        im = Image.new("RGB", (4, 4), (0, 0, 0))
        for x in range(2):
            im.putpixel((x, 0), (255, 255, 255))
        moyenne, mini, maxi = zone(im, 0, 0, 2)
        self.assertAlmostEqual(moyenne, 127.5, places=3)
        self.assertAlmostEqual(mini, 0.0, places=3)
        self.assertAlmostEqual(maxi, 255.0, places=3)

    def testUneImageÀCanalAlphaSeLitQuandMême(self):
        im = Image.new("RGBA", (2, 2), (255, 0, 0, 128))
        self.assertAlmostEqual(point(im, 0, 0), 54.213, places=3)

    def testXYDeZoneEstLeCoinHautGaucheEtNonLeCentre(self):
        # Un seul quadrant blanc, les trois autres noirs : une zone dont X,Y
        # est le centre du blanc mordrait sur les quadrants noirs (moyenne
        # < 255), alors qu'une zone dont X,Y est son coin haut-gauche tombe
        # entièrement dedans (moyenne = 255).
        im = Image.new("RGB", (4, 4), (0, 0, 0))
        for x in range(2, 4):
            for y in range(2, 4):
                im.putpixel((x, y), (255, 255, 255))
        moyenne, mini, maxi = zone(im, 2, 2, 2)
        self.assertAlmostEqual(moyenne, 255.0, places=3)
        self.assertAlmostEqual(mini, 255.0, places=3)


if __name__ == "__main__":
    unittest.main()

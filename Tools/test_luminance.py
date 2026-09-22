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


if __name__ == "__main__":
    unittest.main()

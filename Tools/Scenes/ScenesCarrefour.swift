import CoreGraphics

// MARK: - Les scènes

let scenesCarrefour: [(String, Scene)] = [

    // 1. Priorité à droite pure : aucun panneau, aucun marquage. La seule règle qui joue.
    ("carrefour-priorite-droite", { ctx, p in
        croisementNu(ctx, p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        voiture(ctx, x: seuilEst, y: voieDepuisLaDroite, cap: .ouest, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx + voie - 6, y: voieDepuisLaDroite),
                     CGPoint(x: cx - voie + 8, y: voieDepuisLaDroite)], couleur: p.autre)
    }),

    // 2. STOP sur l'approche du candidat, ligne d'arrêt continue à l'appui.
    ("carrefour-stop", { ctx, p in
        croisementNu(ctx, p)
        ligneDArret(ctx, p)
        panneauStop(ctx, at: CGPoint(x: cx + voie + 24, y: cy + voie + 22), p)
        voiture(ctx, x: voieVous, y: seuilSud + 4, cap: .nord, couleur: p.vous, liseree: true, p)
        voiture(ctx, x: seuilOuest, y: voieDepuisLaGauche, cap: .est, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx - voie + 6, y: voieDepuisLaGauche),
                     CGPoint(x: cx + voie - 8, y: voieDepuisLaGauche)], couleur: p.autre)
    }),

    // 3. Cédez le passage : même situation que le STOP, marquage discontinu à la place du
    //    continu. C'est exactement la confusion que la question fait travailler.
    ("carrefour-cedez-le-passage", { ctx, p in
        croisementNu(ctx, p)
        ligneDeCedez(ctx, p)
        panneauCedez(ctx, at: CGPoint(x: cx + voie + 26, y: cy + voie + 22), p)
        voiture(ctx, x: voieVous, y: seuilSud + 4, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
    }),

    // 4. Même carrefour que la scène 1, un panneau en plus, réponse inverse. C'est la
    //    paire qui fait travailler la règle : la priorité à droite n'est le défaut que
    //    quand rien ne la remplace.
    ("carrefour-route-prioritaire", { ctx, p in
        croisementNu(ctx, p)
        panneauRoutePrioritaire(ctx, at: CGPoint(x: cx + voie + 26, y: cy + voie + 24), p)
        voiture(ctx, x: voieVous, y: seuilSud + 6, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        voiture(ctx, x: seuilEst, y: voieDepuisLaDroite, cap: .ouest, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx + voie - 6, y: voieDepuisLaDroite),
                     CGPoint(x: cx - voie + 8, y: voieDepuisLaDroite)], couleur: p.autre)
    }),

    // 5. Carrefour en T sans aucun panneau. La réponse est contre-intuitive et c'est tout
    //    l'intérêt : le véhicule qui vient de la gauche du candidat doit lui céder le
    //    passage, alors même qu'il roule sur la route qui traverse.
    ("carrefour-en-t", { ctx, p in
        fond(ctx, p)
        chausseeHorizontale(ctx, p)
        chausseeSud(ctx, p)
        axeHorizontal(ctx, p)
        axeSud(ctx, p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        // Le candidat tourne à droite : il rejoint la voie de droite, celle qui va vers
        // l'est — donc exactement celle qu'occupe déjà le véhicule venant de sa gauche.
        // C'est ce recouvrement qui montre le conflit.
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6),
                     CGPoint(x: voieVous, y: voieDepuisLaGauche),
                     CGPoint(x: cx + voie + 34, y: voieDepuisLaGauche)], couleur: p.vous)
        voiture(ctx, x: seuilOuest, y: voieDepuisLaGauche, cap: .est, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx - voie + 6, y: voieDepuisLaGauche),
                     CGPoint(x: cx - 6, y: voieDepuisLaGauche)], couleur: p.autre)
    }),

    // 6. Insertion sur un giratoire, un véhicule déjà engagé sur l'anneau.
    ("rond-point-insertion", { ctx, p in
        fond(ctx, p)
        chausseeHorizontale(ctx, p)
        chausseeVerticale(ctx, p)
        axeHorizontal(ctx, p)
        axeVertical(ctx, p)
        // L'anneau recouvre le croisement : c'est lui qui porte la règle.
        let r = 72.0
        ctx.setFillColor(p.chaussee)
        ctx.fillEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
        ctx.setFillColor(p.ilot)
        ctx.fillEllipse(in: CGRect(x: cx - 32, y: cy - 32, width: 64, height: 64))
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(2)
        ctx.setLineDash(phase: 0, lengths: [7, 7])
        ctx.strokeEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
        ctx.setLineDash(phase: 0, lengths: [])
        panneauCedez(ctx, at: CGPoint(x: cx + voie + 26, y: cy + r + 18), p)
        voiture(ctx, x: voieVous, y: cy + r + demiVoiture, cap: .nord, couleur: p.vous,
                liseree: true, p)
        // Déjà sur l'anneau, et c'est tout l'enjeu : on circule en France dans le sens
        // antihoraire, donc le véhicule qui coupe la route du candidat arrive **par sa
        // gauche**, à neuf heures, en descendant vers la branche sud.
        voiture(ctx, x: cx - 52, y: cy - 6, cap: .sud, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx - 52, y: cy + 20), CGPoint(x: cx - 34, y: cy + 46),
                     CGPoint(x: cx - 6, y: cy + 56)], couleur: p.autre)
    }),
]

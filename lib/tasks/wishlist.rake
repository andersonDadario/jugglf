namespace :jugg do
  def boss(zone, name)
    return if zone.nil? or name.nil? or name.empty?
    zone.children.create(:object => Boss.create(:name => name))
  end
  
  def item(boss, name, note = nil)
    return if boss.nil? or name.nil? or name.empty?
    boss.children.create(:object => Item.find_or_create_by_name(name), 
      :note => note)
  end
  
  desc "Populate wishlist data"
  task :wishlist => [:environment] do
    [Boss, LootTable, Zone].each(&:destroy_all)
    
    ['World Drop'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      boss_name = 'Bind on Equip'
      boss = boss(zone, boss_name)
      
      item(boss, 'Arcanic Tramplers')
      item(boss, 'Benefactor\'s Gauntlets')
      item(boss, 'Bindings of Yearning')
      item(boss, 'Boots of Impetuous Ideals')
      item(boss, 'Boots of Septic Wounds')
      item(boss, 'Gloves of Fast Reactions')
      item(boss, 'Gloves of Token Respect')
      item(boss, 'Inexorable Sabatons')
      item(boss, 'Iron-Spring Jumpers')
      item(boss, 'Mantle of the Eternal Sentinel')
      item(boss, 'Poignant Sabatons')
      item(boss, 'Slime Stream Bands')
      item(boss, 'Spaulders of Egotism')
      item(boss, 'Surge Needle Ring')
      item(boss, 'Torn Web Wrapping')
      item(boss, 'Zeliek\'s Gauntlets')
    end
    
    ['The Obsidian Sanctum (H)', 'The Eye of Eternity (H)'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      boss_name = ( zone_name == 'The Obsidian Sanctum (H)' ) ? 'Sartharion' : 'Malygos'
      boss = boss(zone, boss_name)
      
      case boss_name
      when 'Sartharion'
        item(boss, "Belabored Legplates")
        item(boss, "Bountiful Gauntlets")
        item(boss, "Chestguard of Flagrant Prowess")
        item(boss, "Chestplate of the Great Aspects")
        item(boss, "Concealment Shoulderpads")
        item(boss, "Council Chamber Epaulets")
        item(boss, "Dragon Brood Legguards")
        item(boss, "Dragonstorm Breastplate")
        item(boss, "Fury of the Five Flights")
        item(boss, "Gauntlets of the Lost Conqueror")
        item(boss, "Gauntlets of the Lost Protector")
        item(boss, "Gauntlets of the Lost Vanquisher")
        item(boss, "Headpiece of Reconciliation")
        item(boss, "Hyaline Helm of the Sniper")
        item(boss, "Illustration of the Dragon Soul")
        item(boss, "Leggings of the Honored")
        item(boss, "Obsidian Greathelm")
        item(boss, "Pennant Cloak")
        item(boss, "Staff of Restraint")
        item(boss, "The Sanctum's Flowing Vestments")
        item(boss, "Unsullied Cuffs")
        item(boss, "Upstanding Spaulders")
      when 'Malygos'
        item(boss, "Black Ice")
        item(boss, "Blanketing Robes of Snow")
        item(boss, "Blue Aspect Helm")
        item(boss, "Boots of Healing Energies")
        item(boss, "Boots of the Renewed Flight")
        item(boss, "Chestguard of the Recluse")
        item(boss, "Elevated Lair Pauldrons")
        item(boss, "Footsteps of Malygos")
        item(boss, "Frosted Adroit Handguards")
        item(boss, "Hailstorm")
        item(boss, "Hood of Rationality")
        item(boss, "Ice Spire Scepter")
        item(boss, "Leash of Heedless Magic")
        item(boss, "Leggings of the Wanton Spellcaster")
        item(boss, "Legplates of Sovereignty")
        item(boss, "Living Ice Crystals")
        item(boss, "Mantle of Dissemination")
        item(boss, "Mark of Norgannon")
        item(boss, "Melancholy Sabatons")
        item(boss, "Spaulders of Catatonia")
        item(boss, "Tunic of the Artifact Guardian")
        item(boss, "Unravelling Strands of Sanity")
        item(boss, "Winter Spectacle Gloves")
      end
    end
    
    # Naxxramas ---------------------------------------------------------------
    ['Naxxramas (H)'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      [ 'Trash', 'Anub\'Rekhan', 'Grand Widow Faerlina', 'Maexxna', 
        'Noth the Plaguebringer', 'Heigan the Unclean', 'Loatheb', 'Patchwerk',
        'Grobbulus', 'Thaddius', 'Instructor Razuvious', 'Gothik the Harvester', 
        'Four Horsemen', 'Sapphiron', 'Kel\'Thuzad' ].each do |boss_name|
          boss = boss(zone, boss_name)
          
          case boss_name
          when 'Trash'
            item(boss, "Boots of the Escaped Captive")
            item(boss, "Haunting Call")
            item(boss, "Inevitable Defeat")
            item(boss, "Ousted Bead Necklace")
            item(boss, "Shadow of the Ghoul")
            item(boss, "Shoulderguards of the Undaunted")
            item(boss, "Silent Crusader")
          when 'Anub\'Rekhan'
            item(boss, "Arachnoid Gold Band")
            item(boss, "Chains of Adoration")
            item(boss, "Corpse Scarab Handguards")
            item(boss, "Cryptfiend's Bite")
            item(boss, "Dawnwalkers")
            item(boss, "Gemmed Wand of the Nerubians")
            item(boss, "Leggings of Atrophy")
            item(boss, "Mantle of the Locusts")
            item(boss, "Pauldrons of Unnatural Death")
            item(boss, "Rescinding Grips")
            item(boss, "Ruthlessness")
            item(boss, "Sabatons of Sudden Reprisal")
            item(boss, "Sand-Worn Band")
            item(boss, "Sash of the Parlor")
            item(boss, "Shield of Assimilation")
            item(boss, "Strong-Handed Ring")
            item(boss, "Swarm Bindings")
            item(boss, "Thunderstorm Amulet")
          when 'Grand Widow Faerlina'
            item(boss, "Atonement Greaves")
            item(boss, "Belt of False Dignity")
            item(boss, "Bracers of the Tyrant")
            item(boss, "Callous-Hearted Gauntlets")
            item(boss, "Cult's Chestguard")
            item(boss, "Dislocating Handguards")
            item(boss, "Epaulets of the Grieving Servant")
            item(boss, "Faerlina's Madness")
            item(boss, "Fire-Scorched Greathelm")
            item(boss, "Fool's Trial")
            item(boss, "Heritage")
            item(boss, "Idol of Worship")
            item(boss, "Lost Jewel")
            item(boss, "Punctilious Bindings")
            item(boss, "Ruthlessness")
            item(boss, "Sand-Worn Band")
            item(boss, "Seized Beauty")
            item(boss, "Strong-Handed Ring")
            item(boss, "Thunderstorm Amulet")
            item(boss, "Totem of Misery")
            item(boss, "Tunic of Prejudice")
            item(boss, "Widow's Fury")
          when 'Maexxna'
            item(boss, "Ablative Chitin Girdle")
            item(boss, "Aged Winter Cloak")
            item(boss, "Bindings of the Hapless Prey")
            item(boss, "Cloak of Averted Crisis")
            item(boss, "Cloak of the Shadowed Sun")
            item(boss, "Cowl of the Perished")
            item(boss, "Defender's Code")
            item(boss, "Digested Silken Robes")
            item(boss, "Distorted Limbs")
            item(boss, "Dying Curse")
            item(boss, "Forethought Talisman")
            item(boss, "Grim Toll")
            item(boss, "Helm of Diminished Pride")
            item(boss, "Infectious Skitterer Leggings")
            item(boss, "Mantle of Shattered Kinship")
            item(boss, "Matriarch's Spawn")
            item(boss, "Quivering Tunic")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Sinner's Bindings")
            item(boss, "The Jawbone")
            item(boss, "Undiminished Battleplate")
            item(boss, "Wraith Strike")
          when 'Noth the Plaguebringer'
            item(boss, "Accursed Spine")
            item(boss, "Angry Dread")
            item(boss, "Bands of Impurity")
            item(boss, "Belt of Potent Chanting")
            item(boss, "Crippled Treads")
            item(boss, "Fool's Trial")
            item(boss, "Gauntlets of the Disobedient")
            item(boss, "Gloves of the Fallen Wizard")
            item(boss, "Heritage")
            item(boss, "Legguards of the Undisturbed")
            item(boss, "Libram of Radiance")
            item(boss, "Lost Jewel")
            item(boss, "Robes of Mutation")
            item(boss, "Ruthlessness")
            item(boss, "Sand-Worn Band")
            item(boss, "Shoulderguards of Opportunity")
            item(boss, "Spinning Fate")
            item(boss, "Strong-Handed Ring")
            item(boss, "Thrusting Bands")
            item(boss, "Thunderstorm Amulet")
            item(boss, "Tunic of Masked Suffering")
          when 'Heigan the Unclean'
            item(boss, "Bindings of the Decrepit")
            item(boss, "Breastplate of Tormented Rage")
            item(boss, "Chestguard of Bitter Charms")
            item(boss, "Cloak of Averted Crisis")
            item(boss, "Cloak of the Shadowed Sun")
            item(boss, "Cryptfiend's Bite")
            item(boss, "Defender's Code")
            item(boss, "Dying Curse")
            item(boss, "Eruption-Scared Boots")
            item(boss, "Forethought Talisman")
            item(boss, "Gloves of the Dancing Bear")
            item(boss, "Grim Toll")
            item(boss, "Heigan's Putrid Vestments")
            item(boss, "Helm of Pilgrimage")
            item(boss, "Leggings of Colossal Strides")
            item(boss, "Legguards of the Apostle")
            item(boss, "Serene Echoes")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Sigil of Awareness")
            item(boss, "Stalk-Skin Belt")
            item(boss, "The Undeath Carrier")
          when 'Loatheb'
            item(boss, "Cowl of Innocent Delight")
            item(boss, "Fading Glow")
            item(boss, "Footwraps of Vile Deceit")
            item(boss, "Girdle of Unity")
            item(boss, "Greaves of Turbulence")
            item(boss, "Grotesque Handgrips")
            item(boss, "Mantle of the Lost Conqueror")
            item(boss, "Mantle of the Lost Protector")
            item(boss, "Mantle of the Lost Vanquisher")
            item(boss, "The Hand of Nerub")
            item(boss, "The Impossible Dream")
            item(boss, "Vest of Vitality")
          when 'Patchwerk'
            item(boss, "Arrowsong")
            item(boss, "Belt of the Tortured")
            item(boss, "Boots of Persuasion")
            item(boss, "Crude Discolored Battlegrips")
            item(boss, "Fleshless Girdle")
            item(boss, "Fool's Trial")
            item(boss, "Girdle of the Gambit")
            item(boss, "Gloves of Calculated Risk")
            item(boss, "Heritage")
            item(boss, "Hero's Surrender")
            item(boss, "Libram of Tolerance")
            item(boss, "Lost Jewel")
            item(boss, "Ruthlessness")
            item(boss, "Sash of Solitude")
            item(boss, "Split Greathammer")
            item(boss, "Strong-Handed Ring")
            item(boss, "Thunderstorm Amulet")
            item(boss, "Totem of Hex")
            item(boss, "Waistguard of Divine Grace")
          when 'Grobbulus'
            item(boss, "Bracers of Liberation")
            item(boss, "Chestguard of the Exhausted")
            item(boss, "Cloak of Averted Crisis")
            item(boss, "Cloak of the Shadowed Sun")
            item(boss, "Cowl of Vanity")
            item(boss, "Defender's Code")
            item(boss, "Depraved Linked Belt")
            item(boss, "Desecrated Past")
            item(boss, "Dying Curse")
            item(boss, "Fallout Impervious Tunic")
            item(boss, "Girdle of Chivalry")
            item(boss, "Grim Toll")
            item(boss, "Mantle of the Corrupted")
            item(boss, "Mantle of the Fatigued Sage")
            item(boss, "Origin of Nightmares")
            item(boss, "Plague Igniter")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Spaulders of Incoherence")
            item(boss, "Surplus Limb")
            item(boss, "Sympathetic Amice")
            item(boss, "Tunic of Indulgence")
            item(boss, "Twilight Mist")
          when 'Gluth'
          when 'Thaddius'
            item(boss, "Cincture of Polarity")
            item(boss, "Cover of Silence")
            item(boss, "Faceguard of the Succumbed")
            item(boss, "Headpiece of Fungal Bloom")
            item(boss, "Legplates of the Lost Conqueror")
            item(boss, "Legplates of the Lost Protector")
            item(boss, "Legplates of the Lost Vanquisher")
            item(boss, "Pauldrons of the Abandoned")
            item(boss, "Riveted Abomination Leggings")
            item(boss, "Sabatons of Endurance")
            item(boss, "Spire of Sunset")
            item(boss, "Wraps of the Persecuted")
          when 'Instructor Razuvious'
            item(boss, "Bands of Mutual Respect")
            item(boss, "Bindings of the Expansive Mind")
            item(boss, "Boots of Forlorn Wishes")
            item(boss, "Bracers of the Unholy Knight")
            item(boss, "Chains of Adoration")
            item(boss, "Chestpiece of Suspicion")
            item(boss, "Esteemed Bindings")
            item(boss, "Faithful Steel Sabatons")
            item(boss, "Fool's Trial")
            item(boss, "Gauntlets of Guiding Touch")
            item(boss, "Girdle of Razuvious")
            item(boss, "Girdle of Recuperation")
            item(boss, "Heritage")
            item(boss, "Idol of the Shooting Star")
            item(boss, "Legplates of Double Strikes")
            item(boss, "Ruthlessness")
            item(boss, "Sand-Worn Band")
            item(boss, "Shoulderpads of Secret Arts")
            item(boss, "Strong-Handed Ring")
            item(boss, "Totem of Dueling")
          when 'Gothik the Harvester'
            item(boss, "Abetment Bracers")
            item(boss, "Aged Winter Cloak")
            item(boss, "Bracers of Unrelenting Attack")
            item(boss, "Burdened Shoulderplates")
            item(boss, "Defender's Code")
            item(boss, "Dying Curse")
            item(boss, "Forethought Talisman")
            item(boss, "Gothik's Cowl")
            item(boss, "Grim Toll")
            item(boss, "Helm of Unleashed Energy")
            item(boss, "Helm of Vital Protection")
            item(boss, "Hood of the Exodus")
            item(boss, "Idol of Awakening")
            item(boss, "Leggings of Failed Escape")
            item(boss, "Leggings of Fleeting Moments")
            item(boss, "Libram of Resurgence")
            item(boss, "Life and Death")
            item(boss, "Shackled Cinch")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Touch of Horror")
          when 'Four Horsemen'
            item(boss, "Armageddon")
            item(boss, "Breastplate of the Lost Conqueror")
            item(boss, "Breastplate of the Lost Protector")
            item(boss, "Breastplate of the Lost Vanquisher")
            item(boss, "Broken Promise")
            item(boss, "Damnation")
            item(boss, "Final Voyage")
            item(boss, "Gloves of Peaceful Death")
            item(boss, "Helm of the Grave")
            item(boss, "Leggings of Voracious Shadows")
            item(boss, "Urn of Lost Memories")
          when 'Sapphiron'
            item(boss, "Bandit's Insignia")
            item(boss, "Bone-Inlaid Legguards")
            item(boss, "Boots of the Great Construct")
            item(boss, "Breastplate of Frozen Pain")
            item(boss, "Ceaseless Pity")
            item(boss, "Cosmic Lights")
            item(boss, "Extract of Necromantic Power")
            item(boss, "Gatekeeper")
            item(boss, "Gloves of Grandeur")
            item(boss, "Heroic Key to the Focusing Iris")
            item(boss, "Icy Blast Amulet")
            item(boss, "Legguards of the Boneyard")
            item(boss, "Legwraps of the Defeated Dragon")
            item(boss, "Murder")
            item(boss, "Noble Birthright Pauldrons")
            item(boss, "Platehelm of the Great Wyrm")
            item(boss, "Ring of Decaying Beauty")
            item(boss, "Rune of Repulsion")
            item(boss, "Soul of the Dead")
            item(boss, "Sympathy")
          when 'Kel\'Thuzad'
            item(boss, "Betrayer of Humanity")
            item(boss, "Boundless Ambition")
            item(boss, "Calamity's Grasp")
            item(boss, "Cape of the Unworthy Wizard")
            item(boss, "Crown of the Lost Conqueror")
            item(boss, "Crown of the Lost Protector")
            item(boss, "Crown of the Lost Vanquisher")
            item(boss, "Drape of the Deadly Foe")
            item(boss, "Envoy of Mortality")
            item(boss, "Journey's End")
            item(boss, "Last Laugh")
            item(boss, "Leggings of Mortal Arrogance")
            item(boss, "Signet of Manifested Pain")
            item(boss, "Sinister Revenge")
            item(boss, "The Turning Tide")
            item(boss, "Torch of Holy Fire")
            item(boss, "Voice of Reason")
            item(boss, "Wall of Terror")
          end
        end
    end
  
    ulduar_bosses = ['Bind on Equip', 'Flame Leviathan', 'Razorscale', 
      'Ignis the Furnacemaster', 'XT-002 Deconstructor', 'The Iron Council', 
      'Algalon the Observer', 'Kologarn', 'Hodir', 'Auriaya', 'Thorim', 'Freya', 
      'Mimiron', 'Yogg-Saron']
    
    ['Ulduar'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      ulduar_bosses.each do |boss_name|
        boss = boss(zone, boss_name)
        
        case boss_name
        when 'Flame Leviathan'
          item(boss, "Combustion Bracers")
          item(boss, "Energy Siphon")
          item(boss, "Firesoul")
          item(boss, "Firestrider Chestguard")
          item(boss, "Flamewatch Armguards")
          item(boss, "Gilded Steel Legplates", 'Hard Mode')
          item(boss, "Handguards of Potent Cures", 'Hard Mode')
          item(boss, "Ironsoul")
          item(boss, "Kinetic Ripper")
          item(boss, "Lifespark Visage")
          item(boss, "Mantle of Fiery Vengeance", 'Hard Mode')
          item(boss, "Might of the Leviathan")
          item(boss, "Pyrite Infuser")
          item(boss, "Shimmering Seal", 'Hard Mode')
          item(boss, "Twirling Blades", 'Hard Mode')
        when 'Razorscale'
        when 'Ignis the Furnacemaster'
        when 'XT-002 Deconstructor'
        when 'The Iron Council'
        when 'Algalon the Observer'
        when 'Kologarn'
        when 'General Vezax'
        when 'Hodir'
        when 'Auriaya'
          item(boss, "Archaedas' Lost Legplates")
          item(boss, "Chestplate of Titanic Fury")
          item(boss, "Elemental Focus Stone")
          item(boss, "Ironaya's Discarded Mantle")
          item(boss, "Nimble Climber's Belt")
          item(boss, "Nurturing Touch")
          item(boss, "Raiments of the Corrupted")
          item(boss, "Shieldwall of the Breaker")
        when 'Thorim'
        when 'Freya'
        when 'Mimiron'
        when 'Yogg-Saron'
        end
      end
    end
    
    ['Ulduar (H)'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      ulduar_bosses.each do |boss_name|
        boss = boss(zone, boss_name)
        
        case boss_name
        when 'Flame Leviathan'
          item(boss, "Boots of Fiery Resolution", 'Hard Mode')
          item(boss, "Constructor's Handwraps")
          item(boss, "Embrace of the Leviathan")
          item(boss, "Freya's Choker of Warding")
          item(boss, "Gloves of the Fiery Behemoth")
          item(boss, "Glowing Ring of Reclamation")
          item(boss, "Golden Saronite Dragon", 'Hard Mode')
          item(boss, "Iron Riveted War Helm")
          item(boss, "Mechanist's Bindings")
          item(boss, "Mimiron's Inferno Couplings")
          item(boss, "Overcharged Fuel Rod")
          item(boss, "Pendant of Fiery Havoc", 'Hard Mode')
          item(boss, "Plated Leggings of Ruination", 'Hard Mode')
          item(boss, "Rising Sun")
          item(boss, "Shoulderpads of Dormant Energies", 'Hard Mode')
          item(boss, "Steamcaller's Totem")
          item(boss, "Steamworker's Goggles")
          item(boss, "Strength of the Automaton")
          item(boss, "The Leviathan's Coil")
          item(boss, "Titanguard")
        when 'Razorscale'
        when 'Ignis the Furnacemaster'
        when 'XT-002 Deconstructor'
        when 'The Iron Council'
        when 'Algalon the Observer'
        when 'Kologarn'
        when 'General Vezax'
        when 'Hodir'
        when 'Auriaya'
          item(boss, "Amice of the Stoic Watch")
          item(boss, "Cloak of the Makers")
          item(boss, "Cowl of the Absolute")
          item(boss, "Gloves of the Stonereaper")
          item(boss, "Greaves of the Rockmender")
          item(boss, "Libram of the Resolute")
          item(boss, "Platinum Band of the Aesir")
          item(boss, "Ring of the Faithful Servant")
          item(boss, "Runescribed Blade")
          item(boss, "Sandals of the Ancient Keeper")
          item(boss, "Shoulderplates of the Eternal")
          item(boss, "Siren's Cry")
          item(boss, "Stonerender")
          item(boss, "Unbreakable Chestguard")
          item(boss, "Unwavering Stare")
        when 'Thorim'
        when 'Freya'
        when 'Mimiron'
        when 'Yogg-Saron'
        end
      end
    end
  end
end
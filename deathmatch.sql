-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 23. Nov 2023 um 01:55
-- Server-Version: 10.4.28-MariaDB
-- PHP-Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `dmya`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `achievements`
--

CREATE TABLE `achievements` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Achievement1` int(11) NOT NULL DEFAULT 0,
  `Achievement2` int(11) NOT NULL DEFAULT 0,
  `Achievement3` int(11) NOT NULL DEFAULT 0,
  `Achievement4` int(11) NOT NULL DEFAULT 0,
  `Achievement5` int(11) NOT NULL DEFAULT 0,
  `Achievement6` int(11) NOT NULL DEFAULT 0,
  `Achievement7` int(11) NOT NULL DEFAULT 0,
  `Achievement8` int(11) NOT NULL DEFAULT 0,
  `Achievement9` int(11) NOT NULL DEFAULT 0,
  `Achievement10` int(11) NOT NULL DEFAULT 0,
  `Achievement11` int(11) NOT NULL DEFAULT 0,
  `Achievement12` int(11) NOT NULL DEFAULT 0,
  `Achievement13` int(11) NOT NULL DEFAULT 0,
  `Achievement14` int(11) NOT NULL DEFAULT 0,
  `Achievement15` int(11) NOT NULL DEFAULT 0,
  `Achievement16` int(11) NOT NULL DEFAULT 0,
  `Achievement17` int(11) NOT NULL DEFAULT 0,
  `Achievement18` int(11) NOT NULL DEFAULT 0,
  `Achievement19` int(11) NOT NULL DEFAULT 0,
  `Achievement20` int(11) NOT NULL DEFAULT 0,
  `Achievement21` int(11) NOT NULL DEFAULT 0,
  `Achievement22` int(11) NOT NULL DEFAULT 0,
  `Achievement23` int(11) NOT NULL DEFAULT 0,
  `Achievement24` int(11) NOT NULL DEFAULT 0,
  `Achievement25` int(11) NOT NULL DEFAULT 0,
  `Achievement26` int(11) NOT NULL DEFAULT 0,
  `Achievement27` int(11) DEFAULT 0,
  `Achievement28` int(11) NOT NULL DEFAULT 0,
  `Achievement29` int(11) NOT NULL DEFAULT 0,
  `Achievement30` int(11) NOT NULL DEFAULT 0,
  `Achievement31` int(11) NOT NULL DEFAULT 0,
  `Achievement32` int(11) NOT NULL DEFAULT 0,
  `Achievement33` int(11) NOT NULL DEFAULT 0,
  `Achievement34` int(11) NOT NULL DEFAULT 0,
  `Achievement35` int(11) NOT NULL DEFAULT 0,
  `Achievement36` int(11) NOT NULL DEFAULT 0,
  `Achievement37` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bannedplayers`
--

CREATE TABLE `bannedplayers` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `BannTime` varchar(50) NOT NULL,
  `Grund` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `buycoins`
--

CREATE TABLE `buycoins` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `deaglelobbys`
--

CREATE TABLE `deaglelobbys` (
  `ID` int(11) NOT NULL,
  `Besitzer` varchar(50) NOT NULL,
  `SpielerLimit` int(11) NOT NULL,
  `Willkommensnachricht` text NOT NULL,
  `Passwort` text NOT NULL,
  `Premium` int(11) NOT NULL,
  `Map` int(11) NOT NULL,
  `Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Daten für Tabelle `deaglelobbys`
--

INSERT INTO `deaglelobbys` (`ID`, `Besitzer`, `SpielerLimit`, `Willkommensnachricht`, `Passwort`, `Premium`, `Map`, `Name`) VALUES
(1, 'SERVER', 99, '', '', 1, 1, 'Unnamed DM #1'),
(2, 'SERVER', 99, '', '', 1, 2, 'Unnamed DM #2'),
(3, 'SERVER', 99, '', '', 1, 3, 'Unnamed DM #3');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `deathmatchlobbys`
--

CREATE TABLE `deathmatchlobbys` (
  `ID` int(11) NOT NULL,
  `Besitzer` text NOT NULL,
  `SpielerLimit` int(11) NOT NULL,
  `Willkommensnachricht` text NOT NULL,
  `Passwort` text NOT NULL,
  `Premium` int(11) NOT NULL,
  `Map` int(11) NOT NULL,
  `Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Daten für Tabelle `deathmatchlobbys`
--

INSERT INTO `deathmatchlobbys` (`ID`, `Besitzer`, `SpielerLimit`, `Willkommensnachricht`, `Passwort`, `Premium`, `Map`, `Name`) VALUES
(1, 'SERVER', 99, '', '', 1, 1, 'Unnamed DM #1'),
(2, 'SERVER', 99, '', '', 1, 2, 'Unnamed DM #2'),
(3, 'SERVER', 99, '', '', 1, 3, 'Unnamed DM #3');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mutedplayers`
--

CREATE TABLE `mutedplayers` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `MuteTime` varchar(50) NOT NULL,
  `Grund` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userdata`
--

CREATE TABLE `userdata` (
  `ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Passwort` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Geld` int(11) NOT NULL DEFAULT 0,
  `UnnamedCoins` int(11) NOT NULL DEFAULT 0,
  `Spielstunden` int(11) DEFAULT 0,
  `KillsGesamt` int(11) NOT NULL DEFAULT 0,
  `TodeGesamt` int(11) NOT NULL DEFAULT 0,
  `KillsTacticArena` int(11) NOT NULL DEFAULT 0,
  `TodeTacticArena` int(11) NOT NULL DEFAULT 0,
  `KillsDeagleArena` int(11) NOT NULL DEFAULT 0,
  `TodeDeagleArena` int(11) NOT NULL DEFAULT 0,
  `KillsDeathmatch` int(11) NOT NULL DEFAULT 0,
  `TodeDeathmatch` int(11) NOT NULL DEFAULT 0,
  `DamageGesamt` int(11) NOT NULL DEFAULT 0,
  `DamageTacticArena` int(11) NOT NULL DEFAULT 0,
  `DamageDeagleArena` int(11) NOT NULL DEFAULT 0,
  `DamageDeathmatch` int(11) NOT NULL DEFAULT 0,
  `Adminlevel` int(11) NOT NULL DEFAULT 0,
  `VIPBronzeZeit` varchar(50) NOT NULL DEFAULT '0',
  `VIPSilberZeit` varchar(50) NOT NULL DEFAULT '0',
  `VIPGoldZeit` varchar(50) NOT NULL DEFAULT '0',
  `SkinID` int(11) NOT NULL DEFAULT 0,
  `DeagleKills` int(11) NOT NULL DEFAULT 0,
  `Mp5Kills` int(11) NOT NULL DEFAULT 0,
  `M4Kills` int(11) NOT NULL DEFAULT 0,
  `RifleKills` int(11) NOT NULL DEFAULT 0,
  `Status` varchar(50) NOT NULL DEFAULT 'Unnamed Player',
  `KillsLastHour` int(11) NOT NULL DEFAULT 0,
  `YakuzaSkin` int(11) NOT NULL DEFAULT 141,
  `AngelsOfDeathSkin` int(11) NOT NULL DEFAULT 181,
  `Pokale` int(11) NOT NULL DEFAULT 0,
  `MVPsGesamt` int(11) NOT NULL DEFAULT 0,
  `MVPsTactics` int(11) NOT NULL DEFAULT 0,
  `Achievements` int(11) NOT NULL DEFAULT 0,
  `Waffenshopbuy` varchar(50) NOT NULL DEFAULT '00',
  `NextMapTimer` varchar(50) NOT NULL DEFAULT '0',
  `Lootbox` int(11) NOT NULL DEFAULT 0,
  `Skins` text NOT NULL,
  `SkinNumbers` int(11) NOT NULL DEFAULT 1,
  `LootboxenOpen` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `bannedplayers`
--
ALTER TABLE `bannedplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `buycoins`
--
ALTER TABLE `buycoins`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `deaglelobbys`
--
ALTER TABLE `deaglelobbys`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `deathmatchlobbys`
--
ALTER TABLE `deathmatchlobbys`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `mutedplayers`
--
ALTER TABLE `mutedplayers`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `achievements`
--
ALTER TABLE `achievements`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bannedplayers`
--
ALTER TABLE `bannedplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `buycoins`
--
ALTER TABLE `buycoins`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `deaglelobbys`
--
ALTER TABLE `deaglelobbys`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `deathmatchlobbys`
--
ALTER TABLE `deathmatchlobbys`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `mutedplayers`
--
ALTER TABLE `mutedplayers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `userdata`
--
ALTER TABLE `userdata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

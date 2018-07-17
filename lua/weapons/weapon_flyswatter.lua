AddCSLuaFile()
SWEP.Base           = "weapon_base"
SWEP.PrintName		= "Fly Swatter"
SWEP.Slot		    = 1
SWEP.SlotPos		= 1
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair  = true		
SWEP.ViewModel		= "models/weapons/c_swatter.mdl"	
SWEP.WorldModel		= "models/weapons/w_swatter.mdl"	
SWEP.HoldType		= "melee2"			
SWEP.Weight		    = 3	
SWEP.Purpose		= "For when you go on vacation."	
SWEP.Spawnable		= true			
SWEP.UseHands = true
SWEP.Category 			= "Other"

SWEP.Primary.Ammo	= "none"	
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 50 )
	tr.filter = self.Owner
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 1
		bullet.Damage = 10
			
		self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
		self.Owner:FireBullets(bullet) 
		self.Weapon:EmitSound( "flyswat_new.wav" )
		
	else
		self.Weapon:EmitSound(Sound("weapons/iceaxe/iceaxe_swing1.wav"),100,125)
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	end
end

function SWEP:SecondaryAttack()		
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = false
	return self.AmmoDisplay
end
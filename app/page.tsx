import { fetchPortfolioData, STORAGE_URL } from "@/lib/api";
import {
  personalInfo as fallbackPersonalInfo,
  projects as fallbackProjects,
  timeline as fallbackTimeline,
  stats as fallbackStats,
  skills as fallbackSkills,
  certifications as fallbackCertifications
} from "@/lib/data";
import HeroSection from "@/components/sections/HeroSection";
import SkillsCloud from "@/components/sections/SkillsCloud";
import ProjectsGrid from "@/components/sections/ProjectsGrid";
import ContactForm from "@/components/sections/ContactForm";
import StatsCounters from "@/components/dashboard/StatsCounters";
import SkillsProgress from "@/components/dashboard/SkillsProgress";
import SkillsChart from "@/components/dashboard/SkillsChart";
import CertificationCards from "@/components/dashboard/CertificationCards";
import Timeline from "@/components/dashboard/Timeline";
import Container from "@/components/ui/Container";
import DazzlingTechStack from "@/components/sections/DazzlingTechStack";

// Force ISR with 60 second revalidation
export const revalidate = 60;

export default async function Home() {
  const data = await fetchPortfolioData();

  // Profile Data
  const profile = data?.profile ? {
    name: data.profile.name.charAt(0).toUpperCase() + data.profile.name.slice(1),
    title: data.profile.title,
    email: data.profile.email,
    location: data.profile.location || "Remote",
    bio: data.profile.bio,
    avatar: data.profile.avatar ? `${STORAGE_URL}/${data.profile.avatar}` : fallbackPersonalInfo.avatar,
    socials: data.profile.social_links || fallbackPersonalInfo.socials,
  } : fallbackPersonalInfo;

  // Projects Data
  const projects = data?.projects?.length > 0 ? data.projects.map((p: any) => ({
    ...p,
    id: p.id.toString(),
    technologies: p.skills || [],
  })) : fallbackProjects;

  // Timeline Data
  const timeline = data?.timeline?.length > 0 ? data.timeline.map((t: any) => ({
    ...t,
    id: t.id.toString(),
  })) : fallbackTimeline;

  // Stats Data
  const stats = (data && data.stats && data.stats.length > 0) ? data.stats : fallbackStats;

  // Skills Data
  const skills = (data && data.skills && data.skills.length > 0) ? data.skills : fallbackSkills;

  // Certifications Data
  const certifications = (data && data.certifications && data.certifications.length > 0)
    ? data.certifications.map((c: any) => ({
      ...c,
      id: c.id?.toString() || Math.random().toString(),
      badge: c.image || "",
      credentialUrl: c.credential_url || "",
      credentialId: c.credential_id || "",
      description: c.description || "",
    }))
    : fallbackCertifications;

  return (
    <main className="min-h-screen bg-background text-foreground overflow-x-hidden">
      {/* Hero Section */}
      <section id="hero">
        <HeroSection personalInfo={profile} bio={profile.bio} />
      </section>

      {/* Mission Control (About) Section */}
      <section id="about" className="py-24 bg-background relative z-10 overflow-hidden">
        {/* Section glow */}
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-cyber-blue/5 rounded-full blur-[120px] -z-10"></div>

        <Container>
          <div className="mb-16">
            <h2 className="text-4xl md:text-5xl font-black mb-12 flex items-center">
              <span className="text-cyber-cyan mr-3">/</span>
              Mission Control
            </h2>

            <div className="mb-16">
              <h3 className="text-sm uppercase tracking-[0.3em] text-gray-500 mb-8 font-bold">
                Digital Arsenal
              </h3>
              <DazzlingTechStack skills={skills} />
            </div>

            <StatsCounters stats={stats} />
          </div>
        </Container>
      </section>

      {/* Skills Section */}
      <section id="skills" className="py-10 bg-background relative z-10">
        <Container>
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-16">
            <div className="lg:col-span-2">
              <SkillsProgress skills={skills} />
            </div>
            <div className="lg:col-span-1">
              <SkillsChart skills={skills} />
            </div>
          </div>
        </Container>
      </section>

      {/* Timeline Section */}
      <section id="timeline" className="py-20 bg-background relative z-10">
        <Container>
          <div className="mb-16">
            <Timeline events={timeline} />
          </div>
        </Container>
      </section>

      {/* Certifications Section */}
      <section id="certifications" className="py-20 bg-background relative z-10">
        <Container>
          <div className="mb-16">
            <CertificationCards certifications={certifications} />
          </div>
        </Container>
      </section>

      {/* Skills Cloud */}
      <SkillsCloud skills={skills} />

      {/* Projects Section */}
      <section id="projects" className="py-20">
        <ProjectsGrid projects={projects} />
      </section>

      {/* Contact Section */}
      <section id="contact" className="py-20">
        <ContactForm />
      </section>
    </main>
  );
}
